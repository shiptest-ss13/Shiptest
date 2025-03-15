// Override function, any links and images should
// kill any other marked tokens we don't want here
export const walkTokens = (token) => {
  switch (token.type) {
    case 'url':
    case 'autolink':
    case 'reflink':
    case 'link':
    case 'image':
      token.type = 'text';
      // Once asset system is up change to some default image
      // or rewrite for icon images
      token.href = '';
      break;
  }
};

// This is an extension for marked defining a complete custom tokenizer.
// This tokenizer should run before the the non-custom ones, and gives us
// the ability to handle [_____] fields before the em/strong tokenizers
// mangle them, since underscores are used for italic/bold.
// This massively improves the order of operations, allowing us to run
// marked, THEN sanitise the output (much safer) and finally insert fields
// manually afterwards.
export const inputField = {
  name: 'inputField',
  level: 'inline',

  start(src: string) {
    return src.match(/\[/)?.index;
  },

  tokenizer(src: string) {
    const rule = /^\[_+\]/;
    const match = src.match(rule);
    if (match) {
      const token = {
        type: 'inputField',
        raw: match[0],
      };
      return token;
    }
  },

  renderer(token: { type: string; raw: string }) {
    return `${token.raw}`;
  },
};
