@ECHO OFF

SET TARGET_FOLDER=.\
SET TARGET_FILE=.sql
SET OUT_FILE=.\..\21.Procedure_patch_all.sql
SET MAKE_MERGE_BATCH_FILE=.\merge.cmd

CScript .\_mergeScript.js %TARGET_FOLDER% %TARGET_FILE% %OUT_FILE% %MAKE_MERGE_BATCH_FILE%
