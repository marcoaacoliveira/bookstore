ActiveSupport::Inflector.inflections do |inflect|
	inflect.plural /(ao)$/i , 'oes'
	inflect.singular /oes$/i, 'ao'
	inflect.plural /(or)$/i, '\1es'
	inflect.singular /(or)es$/i, '\1'
	inflect.plural /el$/i, '\1eis'

	inflect.singular /(eis)$/i, 'el'
	inflect.plural /il$/i, 'is'
	inflect.singular /vis$/, 'vil'
	inflect.plural /is$/, 'ises'
	inflect.singular /ises$/, 'is'
end
# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end
