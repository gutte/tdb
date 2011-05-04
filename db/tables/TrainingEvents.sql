CREATE SEQUENCE seqTrainingEvents;
CREATE TABLE TrainingEvents (
TrainingEventID integer not null default nextval('seqTrainingEvents'),
TrainingSessionID integer not null,
TargetDuration interval,
TargetDistance integer,
Duration interval,
Distance integer,
PRIMARY KEY (TrainingEventID),
FOREIGN KEY (TrainingSessionID) REFERENCES TrainingSessions(TrainingSessionID)
);
