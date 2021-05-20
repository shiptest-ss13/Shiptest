import { useBackend, useLocalState } from '../backend';
import { AnimatedNumber, Button, NumberInput, Section, Table, Tabs } from '../components';
import { NtosWindow } from '../layouts';

export const NtosDeptManager = (props, context) => {
  return (
    <NtosWindow
      width={520}
      height={620}
      resizable>
      <NtosWindow.Content scrollable>
        <NtosDeptManagerContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};

export const NtosDeptManagerContent = (props, context) => {
  const { act, data } = useBackend(context);
  const [tab, setTab] = useLocalState(context, 'tab', 1);
  const {
    accounts = [],
    budgets = [],
  } = data;
  return (
    <Section
      title={"Finances Management"}
      buttons={(
        <Tabs>
          <Tabs.Tab
            selected={tab === 1}
            onClick={() => setTab(1)}>
            Employees
          </Tabs.Tab>
          <Tabs.Tab
            selected={tab === 2}
            onClick={() => setTab(2)}>
            Budget Management
          </Tabs.Tab>
        </Tabs>
      )}>
      {tab === 1 && (
        <Table>
          <Table.Row header>
            <Table.Cell>
              Holder
            </Table.Cell>
            <Table.Cell>
              Paycheck
            </Table.Cell>
            <Table.Cell>
              Balance
            </Table.Cell>
            <Table.Cell>
              Actions
            </Table.Cell>
          </Table.Row>
          {accounts.map(account => (
            <Table.Row
              key={account.id}
              className="candystripe">
              <Table.Cell>
                {account.holder}
              </Table.Cell>
              <Table.Cell collapsing>
                <NumberInput
                  minValue={25}
                  maxValue={500}
                  value={account.paycheck}
                  onChange={(e, value) => act('PRG_change_paycheck', {
                    selected_account: account.ref,
                    new_paycheck: value,
                  })} />
              </Table.Cell>
              <Table.Cell collapsing>
                <AnimatedNumber
                  value={account.balance + 'cr'} />
              </Table.Cell>
              <Table.Cell collapsing>
                <Button
                  color={"bad"}
                  content={"Terminate"}
                  onClick={() => act('PRG_terminate_employment', {
                    selected_account: account.ref,
                  })}
                  value={account.balance + 'cr'} />
              </Table.Cell>
            </Table.Row>
          ))}
        </Table>
      )}
      {tab === 2 && (
        <Table>
          <Table.Row header>
            <Table.Cell>
              Budget
            </Table.Cell>
            <Table.Cell>
              Balance
            </Table.Cell>
            <Table.Cell>
              Actions
            </Table.Cell>
          </Table.Row>
          {budgets.map(budget => (
            <Table.Row
              key={budget.name}
              className="candystripe">
              <Table.Cell>
                {budget.name}
              </Table.Cell>
              <Table.Cell>
                <AnimatedNumber
                  value={budget.balance}
                  format={value => Math.round(value) + 'cr'} />
              </Table.Cell>
              <Table.Cell>
                <Button
                  content={budget.frozen ? "UNFREEZE" : "FREEZE"}
                  icon={"exclamation-triangle"}
                  color={budget.frozen && "bad"}
                  onClick={() => act('PRG_freeze_acct', {
                    selected_account: budget.ref,
                  })} />
              </Table.Cell>
            </Table.Row>
          ))}
        </Table>
      )}
    </Section>
  );
};
