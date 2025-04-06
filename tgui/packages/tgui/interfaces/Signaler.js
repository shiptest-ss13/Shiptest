import { toFixed } from 'tgui-core/math';
import { useBackend } from '../backend';
import { Button, Flex, NumberInput, Section } from 'tgui-core/components';
import { Window } from '../layouts';

export const Signaler = (props) => {
  const { act, data } = useBackend();
  const { code, frequency, minFrequency, maxFrequency } = data;
  return (
    <Window width={280} height={132}>
      <Window.Content>
        <Section>
          <Flex>
            <Flex.Column size={1.4} color="label">
              Frequency:
            </Flex.Column>
            <Flex.Column>
              <NumberInput
                animate
                unit="kHz"
                step={0.2}
                stepPixelSize={6}
                minValue={minFrequency / 10}
                maxValue={maxFrequency / 10}
                value={frequency / 10}
                format={(value) => toFixed(value, 1)}
                width="80px"
                onDrag={(e, value) =>
                  act('freq', {
                    freq: value,
                  })
                }
              />
            </Flex.Column>
            <Flex.Column>
              <Button
                ml={1.3}
                icon="sync"
                content="Reset"
                onClick={() =>
                  act('reset', {
                    reset: 'freq',
                  })
                }
              />
            </Flex.Column>
          </Flex>
          <Flex mt={0.6}>
            <Flex.Column size={1.4} color="label">
              Code:
            </Flex.Column>
            <Flex.Column>
              <NumberInput
                animate
                step={1}
                stepPixelSize={6}
                minValue={1}
                maxValue={100}
                value={code}
                width="80px"
                onDrag={(e, value) =>
                  act('code', {
                    code: value,
                  })
                }
              />
            </Flex.Column>
            <Flex.Column>
              <Button
                ml={1.3}
                icon="sync"
                content="Reset"
                onClick={() =>
                  act('reset', {
                    reset: 'code',
                  })
                }
              />
            </Flex.Column>
          </Flex>
          <Flex mt={0.8}>
            <Flex.Column>
              <Button
                mb={-0.1}
                fluid
                icon="arrow-up"
                content="Send Signal"
                textAlign="center"
                onClick={() => act('signal')}
              />
            </Flex.Column>
          </Flex>
        </Section>
      </Window.Content>
    </Window>
  );
};
