#! /bin/bash

DEVELOPMENT="local"
PRODUCTION="prod"
KAFKA_ENV=$(gum choose --header "Choose environment:" $DEVELOPMENT $PRODUCTION)
if [ "$KAFKA_ENV" == $DEVELOPMENT ]; then
	DOMAIN="localhost:8080"
	CLUSTER="local"
else
	DOMAIN="kafka-ui-cyera.axisapps.io"

	MAIN_CLUSTER="main"
	SECONDARY_CLUSTER="secondary"
	OTHER_CLUSTER="other"
	CHOSEN_CLUSTER=$(gum choose --header "Choose cluster:" $MAIN_CLUSTER $SECONDARY_CLUSTER $OTHER_CLUSTER)
	case $CHOSEN_CLUSTER in
		$MAIN_CLUSTER)
			CLUSTER="prod-7451458-us-east-1"
			;;
		$SECONDARY_CLUSTER)
			CLUSTER="prod-7451458-us-east-1-sec"
			;;
		$OTHER_CLUSTER)
			CLUSTER=$(curl -s https://$DOMAIN/api/clusters | jq ".[].name" | gum filter --header "Choose cluster:" | tr -d '"')
			;;
		*)
			gum log -l error "Invalid cluster"
			exit 1
			;;
	esac
fi

TOPICS_LIST=$(gum spin --title "Fetching topics" -- curl -s "https://$DOMAIN/api/clusters/$CLUSTER/topics?&perPage=9999" | jq ".topics[].name")
# If failed or empty
if [ $? -ne 0 ] || [ -z "$TOPICS_LIST" ]; then
	gum log -l error "Failed to fetch topics"
	exit 1
fi
gum log -l debug "Topics count: $(echo "$TOPICS_LIST" | wc -l)"
TOPIC=$(echo "$TOPICS_LIST" | gum filter --header "Choose topic:")

COMMAND="scripts/kafka/kafka-ui.py send --domain $DOMAIN --cluster $CLUSTER --topic $TOPIC --workers 10"
echo $COMMAND
