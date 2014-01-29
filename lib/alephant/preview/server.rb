require 'sinatra/base'
require 'alephant/models/parser'
require 'alephant/models/renderer'
require 'alephant/views/preview'
require 'faraday'
require 'json'
require 'uri'

module Alephant
  module Preview
    class Server < Sinatra::Base

      get '/preview/:id/:region/?:fixture?' do
        render_preview
      end

      get '/component/:id/?:fixture?' do
        render_component
      end

      def render_preview
        ::Alephant::Views::Preview.new(
          { region => render_component },
          preview_template_location
        ).render
      end

      def render_component
        Renderer.new(id, base_path).render(fixture_data)
      end

      private
      def region
        params['region']
      end

      def id
        params['id']
      end

      def fixture
        params['fixture'] || id
      end

      def fixture_data
        parser.parse raw_fixture_data
      end

      def raw_fixture_data
        File.open(fixture_location).read
      end

      def parser
        @parser ||= Parser.new
      end

      def base_path
        "#{Dir.pwd}/views"
      end

      def fixture_location
        "#{base_path}/fixtures/#{fixture}.json"
      end

      def preview_template_location
        "#{base_path}/templates/preview.mustache"
      end
    end
  end
end
