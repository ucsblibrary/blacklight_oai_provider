module BlacklightOaiProvider
  class SolrDocumentProvider < ::OAI::Provider::Base
    attr_accessor :options

    def initialize(controller, options = {})
      options[:provider] ||= {}
      options[:document] ||= {}

      self.class.model = SolrDocumentWrapper.new(controller, options[:document])

      options[:repository_name] ||= controller.view_context.send(:application_name)
      options[:repository_url] ||= controller.view_context.send(:oai_catalog_url)

      options[:provider].each do |k, v|
        self.class.send k, v
      end
    end

    def list_sets(options = {})
      Response::ListSets.new(self.class, options).to_xml
    end
  end
end
