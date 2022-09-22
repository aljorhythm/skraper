import "@testing-library/jest-dom";
import jestFetchMock from "jest-fetch-mock";

const { TextEncoder, TextDecoder } = require("util");
global.TextEncoder = TextEncoder;
global.TextDecoder = TextDecoder;

jestFetchMock.enableMocks();

Object.assign(navigator, {
  clipboard: {
    writeText: () => {},
  },
});
