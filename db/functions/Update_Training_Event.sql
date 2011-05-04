CREATE OR REPLACE FUNCTION Update_Training_Event(TrainingEventID integer, Duration interval, Distance integer) RETURNS INTEGER AS $BODY$
UPDATE TrainingEvents SET Duration = $2, Distance = $3 WHERE TrainingEventID = $1 RETURNING TrainingEventID
$BODY$ LANGUAGE sql VOLATILE;
