import { Button, LabeledList, NoticeBox, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const BankMachine = (props) => {
  const { act, data } = useBackend();
  const { current_balance, siphoning, ship_name } = data;
  return (
    <Window width={335} height={160}>
      <Window.Content>
        <Section title={ship_name + ' Vault'}>
          <LabeledList>
            <LabeledList.Item
              label="Current Balance"
              buttons={
                <Button
                  icon={siphoning ? 'times' : 'sync'}
                  content={siphoning ? 'Stop Siphoning' : 'Siphon Credits'}
                  selected={siphoning}
                  onClick={() => act(siphoning ? 'halt' : 'siphon')}
                />
              }
            >
              {current_balance + ' cr'}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <NoticeBox textAlign="center">Authorized personnel only</NoticeBox>
      </Window.Content>
    </Window>
  );
};
