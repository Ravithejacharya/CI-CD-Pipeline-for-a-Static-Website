// Jest setup file
beforeEach(() => {
  // Clear all mocks before each test
  jest.clearAllMocks();
});

// Mock window.scrollIntoView
Element.prototype.scrollIntoView = jest.fn();

console.log('Jest setup completed');
