CREATE OR REPLACE FUNCTION New_Training_Event(_TrainingSessionID integer, _Duration interval, _Distance integer, _Target boolean) RETURNS INTEGER AS $BODY$
DECLARE
_TrainingEventID integer;
BEGIN
IF _Target IS TRUE THEN
    INSERT INTO TrainingEvents (TrainingSessionID,TargetDuration,TargetDistance)
    VALUES (_TrainingSessionID,_Duration,_Distance)
    RETURNING TrainingEventID INTO STRICT _TrainingEventID;
ELSE
    INSERT INTO TrainingEvents (TrainingSessionID,Duration,Distance)
    VALUES (_TrainingSessionID,_Duration,_Distance)
    RETURNING TrainingEventID INTO STRICT _TrainingEventID;
END IF;
RETURN _TrainingEventID;
END;
$BODY$ LANGUAGE plpgsql VOLATILE;
