# frozen_string_literal: true

# * Style guide based on Rails documention
module Namespace # :nodoc: don't document this

  # Generic Namespace exception class
  class NamespaceError < StandardError
  end

  # Raised when...
  class SpecificError < NamespaceError
  end

  # Document the responsibility of the class
  #
  # == Heading
  #
  # Use headings to break up descriptions
  #
  # == Formatting
  #
  # Embody +parameters+ or +options+ in Teletype Text tags. You can also use
  # *bold* or *italics* but must use HTML tags for <b>multiple words</b>,
  # <i>like this</i> and <tt>like this</tt>.
  class Base

    # RDOC documents constants as well
    MAX_NUMBER_OF_BOOKINGS = 3

    # Write comments above for accessors, this will be presented as [R/W]
    attr_accessor :first_name

    # However this one will be presented as [R]
    attr_reader :name

    def initialize(string) # :notnew: stops RDoc from seeing the initialize method as the new method

    end

    # Desribe the behaviour of the method
    #
    # ==== Attributes
    #
    # * +remove_string+ - Document the first attribute
    # * +append_string+ - Document the second attribute
    # * +options+ - Document the third attribute
    #
    # ==== Options
    #
    # You may which to break out options as a separate item since there maybe
    # multiple items. Note options are prefixed with a colon, denoting them
    # as a
    #
    # * +:conditions+ - An SQL fragment like "administrator = 1"
    # * +:order+ - An SQL fragment like "created_at DESC, name".
    # * +:group+ - An attribute name by which the result should be grouped
    # * +:limit+ - An integer determining the limit on the number of rows that should be returned.
    # * +:offset+ - An integer determining the offset from where the rows should be fetched.
    # * +:joins+ - Either an SQL fragment for additional joins like "LEFT JOIN comments ON comments.post_id = id" (rarely needed)
    #
    # ==== Examples
    #
    # Illustrate the behaviour of the method using examples. Indent examples:
    #
    #    base = Base.new("Example String")
    #    base.method_name("Example", "more")
    def method_name(remove_string, append_string, options)

    end
  end
end
