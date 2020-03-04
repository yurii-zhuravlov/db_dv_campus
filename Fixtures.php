<?php
declare(strict_types=1);

require_once __DIR__ . '/vendor/autoload.php';

/**
 * Class Fixtures
 * @SuppressWarnings(PHPMD.LongVariable)
 */
class Fixtures
{
    private const FAKER_LOCALE = 'uk_UA';
    private const MIN_YEARS = 16;
    private const MAX_YEARS = 45;
    private const MIN_HIRED = 1;
    private const MAX_HIRED = 10;

    /**
     * @var PDO $connection
     */
    private static $connection;

    /** @var Faker\Generator */
    private static $faker;

    /**
     * @return PDO
     */
    private function getConnection(): PDO
    {
        if (null === self::$connection) {
            self::$connection = new PDO(
                'mysql:host=127.0.0.1:3357;dbname=yurii_zhuravlev_cherkasy_electro_trans;charset=utf8',
                'root',
                'root',
                []
            );
            self::$connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        }

        return self::$connection;
    }

    /**
     * @return Faker\Generator
     */
    private function getFaker(): Faker\Generator
    {
        if (null === self::$faker) {
            self::$faker = Faker\Factory::create(self::FAKER_LOCALE);
        }

        return self::$faker;
    }

    /**
     * @param int $gender
     * @return string
     */
    private function getRandomName(int $gender = 1): string
    {
        $faker = $this->getFaker();
        if ($gender === 1) {
            return $faker->firstNameMale;
        }

        return $faker->firstNameFemale;
    }

    /**
     * @return string
     */
    private function getRandomLastName(): string
    {
        return $this->getFaker()->lastName;
    }

    private function cleanup(): void
    {
        $connection = $this->getConnection();
        $connection->exec('DELETE FROM employee WHERE id > 0');
        $connection->exec('ALTER TABLE employee AUTO_INCREMENT = 1');
        $connection->exec('DELETE FROM transport WHERE id > 0');
        $connection->exec('ALTER TABLE transport AUTO_INCREMENT = 1');
        $connection->exec('DELETE FROM salary WHERE id > 0');
        $connection->exec('ALTER TABLE salary AUTO_INCREMENT = 1');
        $connection->exec('DELETE FROM race WHERE id > 0');
        $connection->exec('ALTER TABLE race AUTO_INCREMENT = 1');
        $connection->exec('DELETE FROM position WHERE id > 12');
        $connection->exec('ALTER TABLE position AUTO_INCREMENT = 13');
        $connection->exec('DELETE FROM route WHERE id > 14');
        $connection->exec('ALTER TABLE route AUTO_INCREMENT = 15');
    }

    /**
     * @param string $firstName
     * @param string $lastName
     * @param int $timestamp
     * @return string
     * @throws Exception
     */
    private function getRandomEmail(string $firstName, string $lastName, int $timestamp): string
    {
        $transRules = 'Any-Latin; Latin-ASCII; Lower(); [:Punctuation:] Remove;';
        $transliterator = Transliterator::create($transRules);
        $domain = $this->getFaker()->safeEmailDomain;
        $yearFormat = ['Y', 'y'];
        $isLastName = random_int(0, 1);

        return $transliterator->transliterate($firstName)
        . ($isLastName ? '-' . $transliterator->transliterate($lastName) : '')
        . date($yearFormat[array_rand($yearFormat)], $timestamp)
        . '@'
        . $domain;
    }

    /**
     * @param int $employeeCount
     * @throws Exception
     */
    private function generateEmployers(int $employeeCount): void
    {
        $connection = $this->getConnection();
        $currentTimestamp = time();

        // === CREATE EMPLOYEES ===
        $start = microtime(true);

        $firstName = $lastName = $dob = $gender = $email = $license = $positionId = $monthlySalary = $hired = '';
        $minAgeTimestamp = $currentTimestamp - (31556952 * self::MIN_YEARS);
        $maxAgeTimestamp = $currentTimestamp - (31556952 * self::MAX_YEARS);
        $minHiredTimestamp = $currentTimestamp - (31556952 * self::MIN_HIRED);
        $maxHiredTimestamp = $currentTimestamp - (31556952 * self::MAX_HIRED);
        $statement = $connection->prepare(<<<SQL
    INSERT INTO employee (firstname, lastname, dob, gender, email, license, position_id, monthly_salary, hired)
    VALUES (:firstName, :lastName, :dob, :gender, :email, :license, :positionId, :monthlySalary, :hired)
    ON DUPLICATE KEY UPDATE dob=VALUES(dob), position_id=VALUES(position_id), email=VALUES(email);
SQL
        );
        $statement->bindParam(':firstName', $firstName);
        $statement->bindParam(':lastName', $lastName);
        $statement->bindParam(':dob', $dob);
        $statement->bindParam(':gender', $gender);
        $statement->bindParam(':email', $email);
        $statement->bindParam(':license', $license);
        $statement->bindParam(':positionId', $positionId);
        $statement->bindParam(':monthlySalary', $monthlySalary);
        $statement->bindParam(':hired', $hired);

        for ($employeeId = 0; $employeeId < $employeeCount; $employeeId++) {
            $gender = random_int(1, 2);
            $firstName = $this->getRandomName($gender);
            $lastName = $this->getRandomLastName();
            $timestamp = random_int($maxAgeTimestamp, $minAgeTimestamp);
            $dob = date('Y-m-d', $timestamp);
            $email = $this->getRandomEmail($firstName, $lastName, $timestamp);
            $license = random_int(0, 1);
            $positionId = random_int(1, 12);
            $monthlySalary = random_int(10000, 50000);
            $hiredTimestamp = random_int($maxHiredTimestamp, $minHiredTimestamp);
            $hired = date('Y-m-d', $hiredTimestamp);
            $statement->execute();
        }

        echo 'Create employees: ' . (microtime(true) - $start) . "\n";
    }

    /**
     * @return string
     */
    private function getRandomTransportModel(): string
    {
        $modelFirstName = [
            'LiAZ-',
            'AKSM-',
            'ElectroLAZ-',
            'Bogdan ',
            'Solaris ',
            'Irisbus ',
            'TrolZa-',
            'BTZ-',
            'VMZ-',
            'PKTS-'
        ];
        $modelLastName = [
            '5280',
            '321',
            '12',
            'Т701.10',
            'Trollino 15',
            'Cristalis',
            '5265',
            '52763',
            '62151',
            '6281'
        ];

        return $modelFirstName[array_rand($modelFirstName)]
            . $modelLastName[array_rand($modelLastName)];
    }

    /**
     * @return string
     * @throws Exception
     */
    private function getRandomTransportNumber(): string
    {
        $regionStart = ['CA', 'ІА'];
        $regionEnd = ['A', 'B', 'C', 'E', 'H', 'I', 'K', 'M', 'O', 'P', 'T', 'X', 'Я'];

        return $regionStart[array_rand($regionStart)]
            . random_int(1000, 9999)
            . $regionEnd[array_rand($regionEnd)]
            . $regionEnd[array_rand($regionEnd)];
    }

    /**
     * @param int $transportCount
     * @throws Exception
     */
    private function generateTransports(int $transportCount): void
    {
        $connection = $this->getConnection();

        // === CREATE TRANSPORTS ===
        $start = microtime(true);
        $transportModel = $transportNumber = '';
        $statement = $connection->prepare(<<<SQL
    INSERT INTO transport (model, number)
    VALUES (:model, :number)
    ON DUPLICATE KEY UPDATE number=VALUES(number)
SQL
        );
        $statement->bindParam(':model', $transportModel);
        $statement->bindParam(':number', $transportNumber);

        for ($transportId = 0; $transportId < $transportCount; $transportId++) {
            $transportModel = $this->getRandomTransportModel();
            $transportNumber = $this->getRandomTransportNumber();
            $statement->execute();
        }

        echo 'Create transports: ' . (microtime(true) - $start) . "\n";
    }

    /**
     * @return int
     */
    private function getRandomEmployeeId(): int
    {
        $connection = $this->getConnection();
        $employeeIdsStatement = $connection->query('SELECT id FROM employee');
        $employeeIds = $employeeIdsStatement->fetchAll(PDO::FETCH_COLUMN);

        return (int) $employeeIds[array_rand($employeeIds)];
    }

    /**
     * @return int
     */
    private function getRandomTransportId(): int
    {
        $connection = $this->getConnection();
        $transportIdsStatement = $connection->query('SELECT id FROM transport');
        $transportIds = $transportIdsStatement->fetchAll(PDO::FETCH_COLUMN);

        return (int) $transportIds[array_rand($transportIds)];
    }

    /**
     * @return int
     */
    private function getRandomRouteId(): int
    {
        $connection = $this->getConnection();
        $routeIdsStatement = $connection->query('SELECT id FROM route');
        $routeIds = $routeIdsStatement->fetchAll(PDO::FETCH_COLUMN);

        return (int) $routeIds[array_rand($routeIds)];
    }

    /**
     * @param int $timestampFrom
     * @param int $timestampTo
     * @param string $format
     * @return string
     * @throws Exception
     */
    private function getRandomDate(int $timestampFrom, int $timestampTo, string $format = 'Y-m-d'): string
    {
        $timestamp = random_int($timestampFrom, $timestampTo);

        return date($format, $timestamp);
    }

    /**
     * @param int $salaryCount
     * @throws Exception
     */
    private function generateSalary(int $salaryCount): void
    {
        $connection = $this->getConnection();
        $currentTimestamp = time();

        // === CREATE SALARIES ===
        $start = microtime(true);
        $paidAt = $amount = $employeeId = $positionId = '';
        $statement = $connection->prepare(<<<SQL
    INSERT INTO salary (paid_at, amount, employee_id, position_id)
    VALUES (:paidAt, :amount, :employeeId, :positionId)
SQL
        );
        $statement->bindParam(':paidAt', $paidAt);
        $statement->bindParam(':amount', $amount);
        $statement->bindParam(':employeeId', $employeeId, PDO::PARAM_INT);
        $statement->bindParam(':positionId', $positionId, PDO::PARAM_INT);

        $employeeHiredStatement = $connection->query('SELECT id, hired FROM employee');
        $employeesHired = $employeeHiredStatement->fetchAll(PDO::FETCH_KEY_PAIR);

        $employeePositionStatement = $connection->query('SELECT id, position_id FROM employee');
        $employeesPosition = $employeePositionStatement->fetchAll(PDO::FETCH_KEY_PAIR);

        for ($salaryId = 0; $salaryId < $salaryCount; $salaryId++) {
            $employeeId = $this->getRandomEmployeeId();
            $hiredTimestamp = strtotime($employeesHired[$employeeId]);
            $paidAt = $this->getRandomDate($hiredTimestamp, $currentTimestamp, 'Y-m-d H:i:s');
            $amount = random_int(10000, 50000);
            $positionId = $employeesPosition[$employeeId];
            $statement->execute();
        }

        echo 'Create salaries: ' . (microtime(true) - $start) . "\n";
    }

    /**
     * @param int $racesCount
     * @throws Exception
     */
    private function generateRaces(int $racesCount): void
    {
        $connection = $this->getConnection();
        $currentTimestamp = time();

        // === CREATE PURCHASES ===
        $start = microtime(true);
        $employeeId = $transportId = $routeId = $date = $ticketsSold = $freeRide = '';
        $statement = $connection->prepare(<<<SQL
    INSERT INTO race (employee_id, transport_id, route_id, date, tickets_sold, free_ride)
    VALUES (:employeeId, :transportId, :routeId, :date, :ticketsSold, :freeRide)
SQL
        );
        $statement->bindParam(':employeeId', $employeeId, PDO::PARAM_INT);
        $statement->bindParam(':transportId', $transportId, PDO::PARAM_INT);
        $statement->bindParam(':routeId', $routeId, PDO::PARAM_INT);
        $statement->bindParam(':date', $date);
        $statement->bindParam(':ticketsSold', $ticketsSold, PDO::PARAM_INT);
        $statement->bindParam(':freeRide', $freeRide, PDO::PARAM_INT);

        $employeeHiredStatement = $connection->query('SELECT id, hired FROM employee');
        $employeesHired = $employeeHiredStatement->fetchAll(PDO::FETCH_KEY_PAIR);

        for ($raceId = 0; $raceId < $racesCount; $raceId++) {
            $employeeId = $this->getRandomEmployeeId();
            $transportId = $this->getRandomTransportId();
            $routeId = $this->getRandomRouteId();
            $hiredTimestamp = strtotime($employeesHired[$employeeId]);
            $date = $this->getRandomDate($hiredTimestamp, $currentTimestamp);
            $ticketsSold = random_int(200, 500);
            $freeRide = random_int(350, 750);
            $statement->execute();
        }

        echo 'Create races: ' . (microtime(true) - $start) . "\n";
    }

    /**
     * @return void
     */
    public function generate(): void
    {
        $connection = $this->getConnection();

        try {
            $connection->beginTransaction();
            $this->cleanup();
            $connection->commit();

            $connection->beginTransaction();
            $this->generateEmployers(100);
            $this->generateTransports(100);
            $this->generateSalary(100000);
            $this->generateRaces(1000000);
            $connection->commit();
        } catch (Exception $e) {
            $connection->rollBack();
            echo $e->getMessage();
        }
    }
}

$fixturesGenerator = new Fixtures();
$fixturesGenerator->generate();
