CREATE BITMAP INDEX IX_BRAND ON BRAND (BRAND,ID_BRAND);

CREATE BITMAP INDEX IX_MODEL ON MODEL_ (MODEL_,ID_MODEL);

CREATE INDEX IX_CAR ON CAR(ID_CAR,ID_USER,ID_MODEL,ID_PIC);

CREATE INDEX IX_COMMENT ON COMMENT_(ID_COMMENT,ID_USER,ID_CAR,ID_SPARE);

CREATE INDEX IX_CONTACT ON CONTACTS(ID_CONTACTS,ID_USER);

CREATE INDEX IX_POST ON POST(ID_POST,ID_USER,ID_AUTO,ID_SPARES);

CREATE INDEX IX_SAVED ON SAVED(ID_SAVED,ID_CAR,ID_SPARE,ID_USER);

CREATE INDEX IX_SPARES ON SPARES(ID_SPARES,ID_USER,ID_MODEL,ID_PIC);

CREATE INDEX IX_PICTURE ON PICTURES(ID_PICTURE,ID_CAR,ID_SPARE);
