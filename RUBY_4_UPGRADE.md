# Ruby 4.0.4 Upgrade Guide

This document outlines the Ruby 4.0.4 features and improvements applied to this project.

## Ruby 4.0.4 Key Features

### 1. YJIT - JIT Compiler
- **Status**: YJIT remains available in Ruby 4.0.4
- **Note**: ZJIT is an experimental alternative JIT, but YJIT continues to be the default and recommended JIT compiler
- **Configuration**: 
  - `Procfile` uses `--yjit` flag
  - `Dockerfile` uses `RUBY_YJIT_ENABLE=1` environment variable

### 2. Logical Operator Line Continuation
- **Feature**: Logical operators (`||`, `&&`, `and`, `or`) at the beginning of a line now continue the previous line
- **Example**:
  ```ruby
  # Ruby 4.0.4 allows:
  if condition1
    && condition2
  end
  ```
- **Applied**: Added comments documenting this feature in relevant code

### 3. Array Improvements
- **Array#rfind**: More efficient alternative to `array.reverse_each.find`
- **Array#find**: Optimized override of `Enumerable#find` for better performance
- **Note**: These are automatic optimizations, no code changes needed

### 4. Kernel#inspect Improvements
- **Feature**: Classes can now define `instance_variables_to_inspect` method to control which instance variables are displayed
- **Applied**: Added to `EmptyResult` struct in `app/helpers/helpers.rb` for cleaner debug output

### 5. String Improvements
- **String#strip**: Extended to accept `*selectors` arguments for more flexible string manipulation
- **Unicode**: Updated to Version 17.0.0 and Emoji Version 17.0

### 6. Core Class Promotions
- **Set**: Now a core class (no `require 'set'` needed)
- **Pathname**: Now a core class (no `require 'pathname'` needed)
- **Note**: These are automatic, existing code continues to work

### 7. ErrorHighlight Improvements
- **Feature**: Better error messages showing both caller and callee code snippets
- **Note**: Automatic improvement, no code changes needed

### 8. Language Changes
- **`*nil` behavior**: `*nil` no longer calls `nil.to_a` (similar to `**nil` not calling `nil.to_hash`)
- **Binding changes**: Numbered parameters handling improved in Binding methods

## Files Updated

1. **Gemfile**: Ruby version updated to `4.0.4`
2. **Dockerfile**: 
   - Base image updated to `ruby:4.0.4`
   - JIT configured with YJIT (`RUBY_YJIT_ENABLE=1`)
   - Bundler updated to `4.0.10`
3. **Procfile**: JIT compiler configured as `--yjit`
4. **.ruby-version**: Updated to `4.0.4`
5. **.tool-versions**: Updated to `ruby 4.0.4`
6. **app/helpers/helpers.rb**: 
   - Added `instance_variables_to_inspect` to `EmptyResult`
   - Added Ruby 4.0.4 feature comments
7. **app/views/home.haml**: Improved formatting for better readability

## Breaking Changes

### Removed Methods
- `Ractor.yield` and `Ractor#take` (replaced by `Ractor::Port`)
- `Ractor#close_incoming` and `Ractor#close_outgoing` (replaced by `Ractor::Port`)

### Deprecated
- `ObjectSpace._id2ref` is deprecated

## Performance Improvements

- **YJIT**: Enabled to improve runtime performance
- **Array#find**: Optimized for better performance
- **Array#rfind**: More efficient than `reverse_each.find`
- **Ractor improvements**: Better parallelism and reduced contention

## Next Steps

1. Install Ruby 4.0.4:
   ```bash
   rbenv install 4.0.4
   rbenv local 4.0.4
   ```

2. Update gems:
   ```bash
   bundle update
   ```

3. Run tests:
   ```bash
   bundle exec rspec
   ```

4. Test the application:
   ```bash
   bundle exec rackup
   ```

## References

- [Ruby News](https://www.ruby-lang.org/en/news/)
- [Ruby 4.0.4 NEWS](https://github.com/ruby/ruby/blob/ruby_4_0/NEWS.md)
