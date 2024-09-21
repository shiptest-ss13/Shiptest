import { Collapsible, Flex, Tooltip } from '../../components';
import { isJobOrNameMatch } from './helpers';
import { OrbitItem } from './OrbitItem';
import { OrbitTooltip } from './OrbitTooltip';
import { Observable } from './types';

type Props = {
  color?: string;
  section: Observable[];
  title: string;
  searchQuery: string;
  autoObserve: boolean;
};

/**
 * Displays a collapsible with a map of observable items.
 * Filters the results if there is a provided search query.
 */
export const OrbitSection = (props: Props) => {
  const { color, section = [], title, searchQuery, autoObserve } = props;

  const filteredSection = section.filter((observable) =>
    isJobOrNameMatch(observable, searchQuery)
  );

  if (!filteredSection.length) {
    return null;
  }

  return (
    <Collapsible
      bold
      color={color || 'grey'}
      open={!!color}
      title={title + ` - (${filteredSection.length})`}
    >
      <Flex wrap>
        {filteredSection.map((item) => {
          const content = (
            <OrbitItem
              autoObserve={autoObserve}
              color={color}
              item={item}
              key={item.ref}
            />
          );

          if (!item.health && !item.extra) {
            return content;
          }

          return (
            <Tooltip
              content={<OrbitTooltip item={item} />}
              key={item.ref}
              position="bottom-start"
            >
              {content}
            </Tooltip>
          );
        })}
      </Flex>
    </Collapsible>
  );
};
