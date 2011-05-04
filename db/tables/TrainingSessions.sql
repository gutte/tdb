
-- table: training sessions

CREATE SEQUENCE seqTrainingSessions;
CREATE TABLE TrainingSessions (
TrainingSessionID integer not null default nextval('seqTrainingSessions'),
Datestamp timestamptz not null,
PRIMARY KEY (TrainingSessionID)
);
