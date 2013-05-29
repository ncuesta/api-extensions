def resources
  {
    '/articles/1.json' => {
      'id' => 1,
      'title' => 'Title',
      'name' => 'Name',
      'number' => 9,
      'child' => {
        'nested' => true
      },
      'links' => {
        'self' => { 'href' => '/link/to/self' },
        'other' => { 'href' => '/link/to/other' }
      }
    },
    '/articles.json' => {
      'entries' => [
        {
          'links' => {
            'self' => { 'href' => '/articles/1.json' }
          }
        }
      ],
      'total'   => 1,
      'limit'   => 10,
      'offset'  => 0,
      'links'   => {
        'self' => { 'href' => '/link/to/self' }
      }
    }
  }
end

Given /^I get a request for resource "(.*)"$/ do |resource|
  @request_path = resource
  @response = resources[resource]
end