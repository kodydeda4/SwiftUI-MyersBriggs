# 🏛 UNCW CSC 455 | Myer Briggs

![banner](https://user-images.githubusercontent.com/45678211/116263528-70af8600-a747-11eb-9836-778339326539.png)

## About Myer Briggs

Myer Briggs is an iOS app for the Myer Briggs personality test. It uses the personality type icons, information, and test questions from <https://www.16personalities.com>. It is the final project for CSC 455 - Database Design & Implementation.

## 🧩 16 Types

* 16 Personality Types
* Tap to learn more

![analysts_1](https://user-images.githubusercontent.com/45678211/116251217-76ec3500-a73c-11eb-835e-664b5509888c.png)
![diplomats_1](https://user-images.githubusercontent.com/45678211/116251229-781d6200-a73c-11eb-856c-444c50638f2d.png)
![sentinels_](https://user-images.githubusercontent.com/45678211/116251233-78b5f880-a73c-11eb-8ceb-48d1fc91809a.png)
![explorers_1](https://user-images.githubusercontent.com/45678211/116251232-78b5f880-a73c-11eb-9421-83e9309888bf.png)

![analysts_0](https://user-images.githubusercontent.com/45678211/116251212-76ec3500-a73c-11eb-8700-a4233babf08c.png)
![sentinels_0](https://user-images.githubusercontent.com/45678211/116251236-794e8f00-a73c-11eb-9008-5fd200ad7bcc.png)


## 📖 Assessment

* Animating buttons
* Progressbar
* Switch questions with Sheet View


![assessment_start](https://user-images.githubusercontent.com/45678211/116250084-6b4c3e80-a73b-11eb-83d6-ef9e4ead8a14.png)
![assessment_q2](https://user-images.githubusercontent.com/45678211/116250081-6b4c3e80-a73b-11eb-8058-d8921f079bff.png)
![assessment_sheet](https://user-images.githubusercontent.com/45678211/116250082-6b4c3e80-a73b-11eb-8359-421fc20db673.png)
![assessment_finished](https://user-images.githubusercontent.com/45678211/116250075-6ab3a800-a73b-11eb-9bef-1f8f5b62b266.png)

## 💾 SQL

* SQLite Database
* Queries saved as Swift enum

![sql](https://user-images.githubusercontent.com/45678211/116250086-6be4d500-a73b-11eb-90e8-0dd7664816c1.png)

              case .createTables:
                return """
                create table PersonalityType(
                  personalityId integer primary key not null,
                  description text,
                  fourLetterCode text
                  
                );

                create table PersonalitySpectrum(
                  id integer,
                  introversion float
                );

                create table Response(
                  responseId integer primary key not null,
                  response TEXT
                );

                create table Question(
                  questionId integer primary key not null,
                  content TEXT,
                  responseId integer,
                  personalitySpectrumId integer,
                  FOREIGN KEY (personalitySpectrumId) REFERENCES PersonalitySpectrum(id),
                  FOREIGN KEY (responseId) REFERENCES Response(responseId)
                );

                CREATE TABLE Person (
                  personId INTEGER PRIMARY KEY NOT NULL,
                  name TEXT,
                  assessmentsTaken INTEGER,
                  assessmentResults TEXT NOT NULL
                );
                  
                Create table Assessment(
                 assessmentId integer primary key not null,
                 personId integer,
                 questionId integer,
                 assessmentCount integer,
                 personalityType integer,
                 FOREIGN KEY (questionid) REFERENCES Question(questionId)
                 FOREIGN KEY (personId) REFERENCES Person(personId)
                 FOREIGN KEY (personalityType) REFERENCES PersonalityType(personalityId)
                );
            """

            case .twoTableJoin:
                return """
                SELECT Assessment.assessmentId, Assessment.questionId
                FROM Assessment
                INNER JOIN Question ON Question.questionId = Assessmet.questionId;
                """
            case .threeTableJoin:
                return """
                SELECT Assessment.assessmentId, Assessment.questionId
                FROM Assessment
                INNER JOIN Question ON Question.questionId = Assessmet.questionId
                INNER JOIN PersonalitySpectrum ON PersonalitySpectrum.Id = Question.personalitySpectrumId;
                """

            case .selfJoin:
                return """
                SELECT A.questionId as Assessment1, B.questionId as Assessment2
                FROM Assessment A, Assessment B
                WHERE A.questionId = B.questionId;
                """

            case .aggregateFunction:
                return """
                SELECT COUNT(name)
                FROM Person;
                """

            case .aggregateFunctionExtended:
                return """
                SELECT COUNT(name)
                FROM Person
                GROUP BY assessmentResults;
                """

            case .textBasedSearch:
                return """
                SELECT personId
                FROM Person
                WHERE CONTAINS("Alice")
                """

            case .subQuery:
                return """
                SELECT Assessment.id
                    (SELECT MAX(Person.assessmentsTaken)
                     FROM PersonAS) as max_person
                FROM Person.assessmentsTaken AS p;
                """

            case .storedFunction:
                return """
                CREATE FUNCTION PersonLevel()
                RETURNS VCHAR(15)
                DETERMINISTIC
                BEGIN
                    DECLARE personLevel VARCHAR(15);

                    IF assessmentsTaken > 10 THEN
                        SET personLevel = '3';
                    ELSEIF (assessmentsTaken >= 5 AND
                                                assessmentsTaken <= 10) THEN
                        SET personLevel = '2';
                    ELSEIF assessmentsTaken < 10 THEN
                        SET personLevel = '1';
                    END IF;
                    RETURN (personLevel);
                END$$
                """

            case .storedProcedure:
                return """
                CREATE PROCEDURE setPersonName
                AS
                UPDATE Person
                SET Person.name = new_name
                where Person.name = old_name;
                """

            case .trigger:
                return """
                create trigger assessment_count
                before INSERT
                on
                Assessment
                UPDATE Assessment.Count = Assessment.Count + 1;
                """

## Team Info

![footer](https://user-images.githubusercontent.com/45678211/116249204-91bdaa00-a73a-11eb-895f-e885b70d89bd.png)

|Team Member    | Contact Email              |
| ------------- | ---------------------------|
|Kody Deda      | kodydeda4@gmail.com        |
|Alex           | alexchisholm343@gmail.com  |
|BSam           | nil                        |
