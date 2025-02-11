/*
|| Script:  create-opgs.sql
|| Purpose: Creates Operational Property Graph based on OPG tables
|| Author:  Jim Czuprynski, Zero Defect Computing, Inc.
*/

DROP PROPERTY GRAPH hol23.smi_network;

CREATE OR REPLACE PROPERTY GRAPH hol23.smi_network
  VERTEX TABLES (
    hol23.entities AS MESSENGERS
      KEY ( e_id )
      PROPERTIES ( e_id, e_gender, e_name, e_country, e_tz, e_handle )
   ,hol23.messaging AS MESSAGES
      KEY ( msg_id )
      PROPERTIES ( msg_id, msg_dtm, msg_polarity, msg_subjectivity, msg_text )
  )
  EDGE TABLES (
    hol23.relationships AS CONNECTIONS
      SOURCE KEY ( r_src )      REFERENCES messengers(e_id)
      DESTINATION KEY ( r_tgt ) REFERENCES messengers(e_id)
      PROPERTIES ( r_src, r_tgt, r_type)
   ,hol23.interactions AS INTERACTIONS
      SOURCE KEY ( smi_e_id )        REFERENCES messengers( e_id )
      DESTINATION KEY ( smi_msg_id ) REFERENCES messages( msg_id )
      PROPERTIES ( smi_id, smi_e_id, smi_msg_id, smi_type )
  );
