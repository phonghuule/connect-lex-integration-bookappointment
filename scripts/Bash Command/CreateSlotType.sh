#!/bin/bash
echo "#1 - Create Slot Type AppointmentTypeValue in us-east-1"
aws lex-models put-slot-type --region us-east-1 --name AppointmentTypeValue --cli-input-json file://AppointmentTypeValue.json 
echo "#Done"