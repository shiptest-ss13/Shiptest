#define SHIPTEST_TOPIC var/shiptest_topic_return = SSshiptest.do_topic(args[1]); if(shiptest_topic_return) return shiptest_topic_return
#define SHIPTEST_OOC SSshiptest.ooc_relay(client, msg);

#define SHIPTEST_TOPIC_PING "PING"
#define SHIPTEST_TOPIC_OOC_RELAY "OOC"

#define SHIPTEST_TOPIC_RESPONSE_GOOD "TOPIC-GOOD"
#define SHIPTEST_TOPIC_RESPONSE_BAD_COMMAND "TOPIC-UNKNOWN"
