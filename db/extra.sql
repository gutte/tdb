


CREATE SEQUENCE seqTrainingCategories;
CREATE TABLE TrainingCategories (
TrainingCategoryID integer not null default nextval('seqTrainingCategories'),
Name text not null,
PRIMARY KEY (TrainingCategoryID),
UNIQUE(Name)
);

CREATE TABLE TrainingActivities (
TrainingActivityID integer not null,
TrainingCategoryID integer not null,
Name text not null,
PRIMARY KEY (TrainingActivityID),
FOREIGN KEY (TrainingCategoryID) REFERENCES TrainingCategories(TrainingCategoryID),
UNIQUE(Name)
);


