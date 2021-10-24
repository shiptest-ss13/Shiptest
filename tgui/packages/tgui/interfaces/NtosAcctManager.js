import { useBackend, useLocalState } from '../backend';
import { createSearch } from 'common/string';
import { Fragment } from 'inferno';
import { AnimatedNumber, Button, Dropdown, Input, LabeledList, NumberInput, Section, Table, Tabs } from '../components';
import { NtosWindow } from '../layouts';

export const NtosAcctManager = (props, context) => {
  return (
    <NtosWindow
      width={550}
      height={620}
      resizable>
      <NtosWindow.Content scrollable>
        <NtosBankAcctManagerContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};

export const NtosBankAcctManagerContent = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    authed,
    jobs = [],
    accounts = [],
  } = data;

  const [tab, setTab] = useLocalState(context, 'tab', 1);
  const [searchText, setSearchText] = useLocalState(context, 'searchText', '');
  const [acctName, setAcctName] = useLocalState(context, 'acctName', '');
  const [acctID, setAcctID] = useLocalState(context, 'acctID', '111111');
  const [acctJob, setAcctJob] = useLocalState(context, 'acctJob', jobs[0]);

  const holderSearch = createSearch(searchText, item => {
    return item.holder;
  });

  const idSearch = createSearch(searchText, item => {
    return item.id;
  });

  const items = searchText.length > 0
   && accounts
     .filter(holderSearch)
    || accounts;

  return (
    <Fragment>
      <Tabs>
        <Tabs.Tab
          selected={tab === 1}
          onClick={() => setTab(1)}>
          Account Management
        </Tabs.Tab>
        <Tabs.Tab
          selected={tab === 2}
          onClick={() => setTab(2)}>
          Account Creation
        </Tabs.Tab>
      </Tabs>
      {tab === 1 && (
        <Section
          title={"Account Management"}
          buttons={(
            <Fragment>
              Search
              <Input
                autoFocus
                value={searchText}
                onInput={(e, value) => setSearchText(value)}
                mx={1} />
            </Fragment>
          )}>
          <Table>
            <Table.Row header>
              <Table.Cell />
              <Table.Cell>
                ID
              </Table.Cell>
              <Table.Cell>
                Holder
              </Table.Cell>
              <Table.Cell>
                Paycheck Grade
              </Table.Cell>
              <Table.Cell>
                Balance
              </Table.Cell>
            </Table.Row>
            {items.map(account => (
              <Table.Row
                key={account.id}
                className="candystripe">
                <Table.Cell collapsing>
                  <Button
                    icon={"window-close-o"}
                    color={"bad"}
                    onClick={() => act('PRG_close_account', {
                      selected_account: account.ref,
                    })} />
                </Table.Cell>
                <Table.Cell collapsing>
                  <NumberInput
                    minValue={111111}
                    maxValue={999999}
                    disabled={!authed}
                    value={account.id}
                    onChange={(e, value) => act('PRG_change_id', {
                      selected_account: account.ref,
                      new_id: value,
                    })} />
                </Table.Cell>
                <Table.Cell>
                  <Input
                    fluid
                    value={account.holder}
                    disabled={!authed}
                    onChange={(e, value) => act('PRG_change_holder', {
                      selected_account: account.ref,
                      new_holder: value,
                    })} />
                </Table.Cell>
                <Table.Cell collapsing>
                  <Dropdown
                    options={jobs}
                    disabled={!authed}
                    width={15}
                    selected={account.job}
                    onSelected={value => act('PRG_change_job', {
                      selected_account: account.ref,
                      new_job: value,
                    })} />
                </Table.Cell>
                <Table.Cell collapsing>
                  <AnimatedNumber
                    value={account.balance}
                    format={value => Math.round(value) + 'cr'} />
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
        </Section>
      )}
      {tab === 2 && (
        <Section
          title={"New Account Creation"}
          buttons={(
            <Button.Confirm
              content={"Create Account"}
              icon={"check"}
              confirmMessage={"Create?"}
              confirmColor={"good"}
              onClick={() => act('PRG_new_account', {
                acct_holder: acctName,
                acct_id: acctID,
                acct_job: acctJob,
              })} />
          )}>
          <LabeledList>
            <LabeledList.Item label={"Holder"}>
              <Input
                value={acctName}
                onChange={(e, value) => setAcctName(value)} />
            </LabeledList.Item>
            <LabeledList.Item label={"ID"}>
              <NumberInput
                value={acctID}
                minValue={111111}
                maxValue={999999}
                onChange={(e, value) => setAcctID(value)} />
            </LabeledList.Item>
            <LabeledList.Item label={"Job"}>
              <Dropdown
                options={jobs}
                disabled={!authed}
                selected={acctJob}
                width={17}
                onSelected={value => setAcctJob(value)} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      )}
    </Fragment>
  );
};
