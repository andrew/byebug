require_relative 'test_helper'

describe "Continue Command" do
  include TestDsl

  describe "successful" do
    it "must continue up to breakpoint if no line specified" do
      enter 'break 4', 'continue'
      debug_file('continue') { state.line.must_equal 4 }
    end

    it "must work in abbreviated mode too" do
      enter 'break 4', 'cont'
      debug_file('continue') { state.line.must_equal 4 }
    end

    it "must continue up to specified line" do
      enter 'cont 4'
      debug_file('continue') { state.line.must_equal 4 }
    end

    # XXX: Decide whether to keep original behaviour (i don't like it but maybe
    # I'm wrong) or make the test below pass
    #it "must not keep temporal breakpoint when line specified" do
    #  enter 'cont 4'
    #  debug_file('continue') { Byebug.breakpoints.size.must_equal 0 }
    #end
  end

  describe "unsuccessful" do
    it "must ignore the command if specified line is not valid" do
      enter 'cont 123'
      debug_file('continue') { state.line.must_equal 2 }
    end

    it "must show error if specified line is not valid" do
      enter 'cont 123'
      debug_file('continue')
      check_output_includes "Line 123 is not a stopping point in file \"#{fullpath('continue')}\".", interface.error_queue
    end

    it "must ignore the line if the context is dead"
  end
end
