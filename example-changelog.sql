--liquibase formatted sql

--changeset your.name:1 labels:example-label context:example-context
--comment: example comment
create table person (
    id int ,
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)
--rollback DROP TABLE person;

--changeset your.name:2 labels:example-label context:example-context
--comment: example comment
create table company (
    id int ,
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)
--rollback DROP TABLE company;

--changeset other.dev:3 labels:example-label context:example-context
--comment: example comment
alter table person add column country varchar(2)
--rollback ALTER TABLE person DROP COLUMN country;

--changeset other.dev:4 labels:example-label context:example-context
alter table person add column state varchar(2)
--rollback ALTER TABLE person DROP COLUMN state;


--changeset bhawana:5 labels:example-label context:example-context
--comment: example comment
alter table person add column gender varchar(2)
--rollback ALTER TABLE person DROP COLUMN gender;


--changeset bhawana:6 labels:example-label context:example-context
--comment: example comment
alter table person add column lname varchar(20)
--rollback ALTER TABLE person DROP COLUMN lname;

--changeset bhawana:7 labels:example-label context:example-context
--comment: example comment
alter table person add column fname varchar(20)
--rollback ALTER TABLE person DROP COLUMN fname;

--changeset bhavana:8 labels:example-label2 context:example-context
--comment: update of column
alter table person DROP column fname
--rollback ALTER TABLE person ADD COLUMN fname;

--changeset bhavana:9 labels:update column context:example-context
--comment: update of column1
alter table person add column college varchar(20)
--rollback ALTER TABLE person DROP COLUMN college;

--changeset bhavana:10 labels:update column context:example-context 
--tag: version2
--comment: update of column1
alter table person add column place varchar(20)
--rollback ALTER TABLE person DROP COLUMN place;

--changeset bhavana:11 labels:update column context:example-context 
--tag: version2
--comment: update of column1
alter table person DROP column college
--rollback ALTER TABLE person ADD COLUMN college varchar(20);

--changeset bhavana:12 labels:update column context:example-context 
--tag: version3
--comment: update of column1
alter table company ADD column domain varchar(20)
--rollback ALTER TABLE company DROP COLUMN domain;

--changeset bhavana:13 labels:update column context:example-context 
--tag: version3
--comment: update of column1
alter table company ADD column year int
--rollback ALTER TABLE company DROP COLUMN year;

--changeset bhavana:14 labels:update column context:example-context 
--tag: version3
--comment: update of column1
alter table company ADD column state varchar(20)
--rollback ALTER TABLE company DROP COLUMN state;

--changeset bhavana:15 labels:update column context:example-context 
--tag: version3
--comment: update of column1
alter table company DROP column address2
--rollback ALTER TABLE company ADD COLUMN address2 varchar(50);

--changeset bhavana:16 labels:update column context:example-context 
--tag: version3
--comment: update of column1
alter table company DROP column addres1
--rollback ALTER TABLE company ADD COLUMN address1 varchar(50);

--changeset bhavana:17 labels:update column context:example-context
--comment: update of column1
alter table person add column college1 varchar(20)
--rollback ALTER TABLE person DROP COLUMN college1;

--changeset bhavana:18 labels:update column context:example-context
--comment: update of column1
alter table person add column college2 varchar(20)
--rollback ALTER TABLE person DROP COLUMN college2;
