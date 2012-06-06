require 'base64'
require 'roxml'

module Veracode
  module Result
    class Base
      include ROXML
    end
    
    class Screenshot < Base
      xml_reader :format, :from => "@format"
      
      xml_reader(:data) {|b64data| Base64.decode64(b64data) }
    end
    
    class BulletType < Base
      xml_reader :text, :from => "@text"
    end
    
    class ParaType  < Base
      xml_reader :bulletitem, :as => [BulletType]
      xml_reader :text, :from => "@text"
    end
    
    class TextType < Base
      xml_reader :text, :from => "text/@text"
    end
    
    class Para < Base
      xml_reader :para, :as => [ParaType]
    end
    
    class AppendixType < Base
      xml_reader :description
      xml_reader :screenshot, :as => [Screenshot]
      xml_reader :code
    end
    
    class Modules < Base
      xml_reader :name, :from => "@name"
      xml_reader :compiler, :from => "@compiler"
      xml_reader :os, :from => "@os"
      xml_reader :architecture, :from => "@architecture"
      xml_reader :score, :from => "@score"
      xml_reader :numflawssev0, :from => "@numflawssev0"
      xml_reader :numflawssev1, :from => "@numflawssev1"
      xml_reader :numflawssev2, :from => "@numflawssev2" 
      xml_reader :numflawssev3, :from => "@numflawssev3" 
      xml_reader :numflawssev4, :from => "@numflawssev4" 
      xml_reader :numflawssev5, :from => "@numflawssev5"
    end
    
    class Analysis < Base
      xml_reader :rating, :from => "@rating"
      xml_reader :score, :from => "@score"
      xml_reader :submitted_date, :from => "@submitted_date"
      xml_reader :published_date, :from => "@published_date"
      xml_reader :mitigated_rating, :from => "@mitigated_rating"
      xml_reader :mitigated_score, :from => "@mitigated_score"
      xml_reader :analysis_size_bytes, :from => "@analysis_size_bytes"
      xml_reader :next_scan_due, :from => "@next_scan_due"
      
      xml_reader :modules, :as => [Modules]
    end
      
    class ManualAnalysis < Base
      xml_reader :rating, :from => "@rating"
      xml_reader :score, :from => "@score"
      xml_reader :mitigated_rating, :from => "@mitigated_rating"
      xml_reader :mitigated_score, :from => "@mitigated_score"
      xml_reader :submitted_date, :from => "@submitted_date"
      xml_reader :published_date, :from => "@published_date"
      xml_reader :next_scan_due, :from => "@next_scan_due"

      xml_reader :modules, :as => [Modules]
      xml_reader :cia_adjustment
      xml_reader :delivery_consultant
    end
    
    class FlawStatus < Base
      xml_reader :new, :from => :attr
      xml_reader :reopen, :from => :attr
      xml_reader :open, :from => :attr
      xml_reader :fixed, :from => :attr
      xml_reader :total, :from => :attr
      xml_reader :not_mitigated, :from => :attr
      xml_reader :sev_1_change, :from => :attr
      xml_reader :sev_2_change, :from => :attr
      xml_reader :sev_3_change, :from => :attr
      xml_reader :sev_4_change, :from => :attr
      xml_reader :sev_5_change, :from => :attr
    end
  end
end