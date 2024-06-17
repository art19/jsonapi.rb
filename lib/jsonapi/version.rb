module JSONAPI
  ##
  # ART19 maintains a fork with patches applied on top of the upstream gem.
  # We publish our fork with a revision number appended to the upstream version.
  #
  # @return [String] the ART19 revision number
  ART19_REVISION = '1'.freeze
  VERSION = "2.0.1.#{ART19_REVISION}".freeze
end
