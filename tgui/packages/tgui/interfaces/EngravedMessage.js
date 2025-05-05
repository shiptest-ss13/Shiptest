import { Box, Button, Flex, LabeledList, Section } from 'tgui-core/components';
import { decodeHtmlEntities } from 'tgui-core/string';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const EngravedMessage = (props) => {
  const { act, data } = useBackend();
  const {
    admin_mode,
    creator_key,
    creator_name,
    has_liked,
    has_disliked,
    hidden_message,
    is_creator,
    num_likes,
    num_dislikes,
    realdate,
  } = data;
  return (
    <Window width={600} height={300} resizable>
      <Window.Content scrollable>
        <Section>
          <Box bold textAlign="center" fontSize="20px" mb={2}>
            {decodeHtmlEntities(hidden_message)}
          </Box>
          <Flex>
            <Flex.Column>
              <Button
                fluid
                icon="arrow-up"
                content={' ' + num_likes}
                disabled={is_creator}
                selected={has_liked}
                textAlign="center"
                fontSize="16px"
                lineHeight="24px"
                onClick={() => act('like')}
              />
            </Flex.Column>
            <Flex.Column>
              <Button
                fluid
                icon="circle"
                disabled={is_creator}
                selected={!has_disliked && !has_liked}
                textAlign="center"
                fontSize="16px"
                lineHeight="24px"
                onClick={() => act('neutral')}
              />
            </Flex.Column>
            <Flex.Column>
              <Button
                fluid
                icon="arrow-down"
                content={' ' + num_dislikes}
                disabled={is_creator}
                selected={has_disliked}
                textAlign="center"
                fontSize="16px"
                lineHeight="24px"
                onClick={() => act('dislike')}
              />
            </Flex.Column>
          </Flex>
        </Section>
        <Section>
          <LabeledList>
            <LabeledList.Item label="Created On">{realdate}</LabeledList.Item>
          </LabeledList>
        </Section>
        <Section />
        {!!admin_mode && (
          <Section
            title="Admin Panel"
            buttons={
              <Button
                icon="times"
                content="Delete"
                color="bad"
                onClick={() => act('delete')}
              />
            }
          >
            <LabeledList>
              <LabeledList.Item label="Creator Ckey">
                {creator_key}
              </LabeledList.Item>
              <LabeledList.Item label="Creator Character Name">
                {creator_name}
              </LabeledList.Item>
            </LabeledList>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
