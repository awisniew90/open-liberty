CREATE TABLE ${schemaname}.PREV_ADDRESSES (SpecEmployeeOLGH16588_ID NUMBER, city VARCHAR2(255), state VARCHAR2(255), street VARCHAR2(255), zipcode VARCHAR2(255));
CREATE TABLE ${schemaname}.SpecEmployeeOLGH16588 (id NUMBER NOT NULL, city VARCHAR2(255), state VARCHAR2(255), street VARCHAR2(255), zipcode VARCHAR2(255), PRIMARY KEY (id));
CREATE TABLE ${schemaname}.SpecEmployeeOLGH16588_SpecPhoneOLGH16588 (SpecEmployeeOLGH16588_ID NUMBER, phones_ID NUMBER);
CREATE TABLE ${schemaname}.SpecPhoneOLGH16588 (id NUMBER NOT NULL, vendor VARCHAR2(255), PRIMARY KEY (id));
CREATE INDEX ${schemaname}.I_PRV_SSS_SPECCONTACTINFOOLGH1 ON ${schemaname}.PREV_ADDRESSES (SpecEmployeeOLGH16588_ID);
CREATE INDEX ${schemaname}.I_SPCMPHN_ELEMENT ON ${schemaname}.SpecEmployeeOLGH16588_SpecPhoneOLGH16588 (phones_ID);
CREATE INDEX ${schemaname}.I_SPCMPHN_SPECCONTACTINFOOLGH1 ON ${schemaname}.SpecEmployeeOLGH16588_SpecPhoneOLGH16588 (SpecEmployeeOLGH16588_ID);