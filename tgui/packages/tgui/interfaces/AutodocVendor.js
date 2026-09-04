import { useBackend } from '../backend';
import { Button, LabeledList, Section, Box } from '../components';
import { ButtonConfirm } from '../components/Button';
import { Window } from '../layouts';

export const AutodocVendor = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    uses,
    heal_flags,
    user,
    cost,
    free,

    cost_basic,
    cost_complex,
    cost_organs,
    cost_oxy,

    do_brute,
    do_burn,
    do_tox,
    do_oxy,
    do_clone,

    do_organs,
    do_wounds,
    do_revive,
  } = data;
  let toggle_brute = heal_flags & do_brute ? 1 : 0;
  let toggle_burn = heal_flags & do_burn ? 1 : 0;
  let toggle_tox = heal_flags & do_tox ? 1 : 0;
  let toggle_oxy = heal_flags & do_oxy ? 1 : 0;
  let toggle_clone = heal_flags & do_clone ? 1 : 0;

  let toggle_wounds = heal_flags & do_wounds ? 1 : 0;
  let toggle_organs = heal_flags & do_organs ? 1 : 0;
  let toggle_revive = heal_flags & do_revive ? 1 : 0;

  let canAfford;
  if ((user && user.cash > cost) || free) {
    canAfford = 1;
  } else {
    canAfford = 0;
  }
  return (
    <Window width={270} height={500}>
      <Window.Content>
        {!free && (
          <Section title="User">
            {(user && (
              <Box>
                Welcome, <b>{user.name}</b>!
                <br />
                Your balance is{' '}
                <b>
                  {user.cash} {'credits'}
                </b>
                .
              </Box>
            )) || (
              <Box color="light-grey">
                No registered cash card!
                <br />
                Please contact your local bank!
              </Box>
            )}
          </Section>
        )}
        <Section title={'Select parameters'}>
          <LabeledList>
            <LabeledList.Item label="Procedures">
              <Button
                content="Tissue Damage"
                icon={toggle_brute ? 'toggle-on' : 'toggle-off'}
                color={toggle_brute ? 'green' : 'red'}
                onClick={() =>
                  act('toggle-procedure', {
                    'toggle': toggle_brute,
                    'flag': do_brute,
                    'adjustcost': cost_basic,
                  })
                }
              />
              <Button
                content="Burns"
                icon={toggle_burn ? 'toggle-on' : 'toggle-off'}
                color={toggle_burn ? 'green' : 'red'}
                onClick={() =>
                  act('toggle-procedure', {
                    'toggle': toggle_burn,
                    'flag': do_burn,
                    'adjustcost': cost_basic,
                  })
                }
              />
              <Button
                content="Toxin Purge"
                icon={toggle_tox ? 'toggle-on' : 'toggle-off'}
                color={toggle_tox ? 'green' : 'red'}
                onClick={() =>
                  act('toggle-procedure', {
                    'toggle': toggle_tox,
                    'flag': do_tox,
                    'adjustcost': cost_basic,
                  })
                }
              />
              <Button
                content="Respiratory Damage"
                icon={toggle_oxy ? 'toggle-on' : 'toggle-off'}
                color={toggle_oxy ? 'green' : 'red'}
                onClick={() =>
                  act('toggle-procedure', {
                    'toggle': toggle_oxy,
                    'flag': do_oxy,
                    'adjustcost': cost_oxy,
                  })
                }
              />
              <Button
                content="Cellular Damage"
                icon={toggle_clone ? 'toggle-on' : 'toggle-off'}
                color={toggle_clone ? 'green' : 'red'}
                onClick={() =>
                  act('toggle-procedure', {
                    'toggle': toggle_clone,
                    'flag': do_clone,
                    'adjustcost': cost_complex,
                  })
                }
              />
              <Button
                content="Complex Wounds"
                icon={toggle_wounds ? 'toggle-on' : 'toggle-off'}
                color={toggle_wounds ? 'green' : 'red'}
                onClick={() =>
                  act('toggle-procedure', {
                    'toggle': toggle_wounds,
                    'flag': do_wounds,
                    'adjustcost': cost_complex,
                  })
                }
              />
              <Button
                content="Organ Damage"
                icon={toggle_organs ? 'toggle-on' : 'toggle-off'}
                color={toggle_organs ? 'green' : 'red'}
                onClick={() =>
                  act('toggle-procedure', {
                    'toggle': toggle_organs,
                    'flag': do_organs,
                    'adjustcost': cost_organs,
                  })
                }
              />
              <Button
                content="Resuscitation"
                icon={toggle_revive ? 'toggle-on' : 'toggle-off'}
                color={toggle_revive ? 'green' : 'red'}
                onClick={() =>
                  act('toggle-procedure', {
                    'toggle': toggle_revive,
                    'flag': do_revive,
                    'adjustcost': cost_complex,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item label="Uses">{uses}</LabeledList.Item>
            <LabeledList.Item label="Adjust Uses">
              <Button icon="minus" onClick={() => act('less-uses')} />
              <Button icon="plus" onClick={() => act('more-uses')} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title={'Print'}>
          <LabeledList>
            {!free && (
              <LabeledList.Item label="Cost" color={canAfford ? 'good' : 'bad'}>
                {cost}
                {' credits'}
              </LabeledList.Item>
            )}
            <LabeledList.Item>
              <ButtonConfirm
                content="Print"
                icon="floppy-disk"
                onClick={() => act('print', { 'canafford': canAfford })}
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
