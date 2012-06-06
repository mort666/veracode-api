require 'veracode/api/types'

module Veracode
  module Result
    class AnnotationType < Base
      xml_reader :action, :from => :attr
      xml_reader :description, :from => :attr
      xml_reader :user, :from => :attr
      xml_reader :date, :from => :attr
    end
    
    class Annotations < Base
      xml_reader :annotation, :as => [AnnotationType]
    end
    
    class MitigationType < Base
      xml_reader :action, :from => :attr
      xml_reader :description, :from => :attr
      xml_reader :user, :from => :attr
      xml_reader :date, :from => :attr
    end
    
    class Mitigations < Base
      xml_reader :mitigation, :as => [MitigationType]
    end
    
    class ExploitabilityAdjustment < Base
      xml_reader :note
      xml_reader :score_adjustment, :from => :attr
    end
    
    class ExploitAdjustment < Base
      xml_reader :exploitability_adjustment, :as => ExploitabilityAdjustment
    end
    
    class Flaw < Base
      xml_reader :severity, :from => :attr
      xml_reader :categoryname, :from => :attr
      xml_reader :count, :from => :attr
      xml_reader :issueid, :from => :attr
      xml_reader :module, :from => :attr
      xml_reader :type, :from => :attr
      xml_reader :description, :from => :attr
      xml_reader :note, :from => :attr
      xml_reader :cweid, :from => :attr
      xml_reader :remediationeffort, :from => :attr
      xml_reader :exploitLevel, :from => :attr
      xml_reader :categoryid, :from => :attr
      xml_reader :pcirelated?, :from => :attr
      xml_reader :date_first_occurrence, :from => :attr
      xml_reader :remediation_status, :from => :attr
      xml_reader :sourcefile, :from => :attr
      xml_reader :line, :from => :attr
      xml_reader :sourcefilepath, :from => :attr
      xml_reader :scope, :from => :attr
      xml_reader :functionprototype, :from => :attr
      xml_reader :functionrelativelocation, :from => :attr
      xml_reader :url, :from => :attr
      xml_reader :vuln_parameter, :from => :attr
      xml_reader :location, :from => :attr
      xml_reader :cvss, :from => :attr
      xml_reader :capecid, :from => :attr
      xml_reader :exploitdifficulty, :from => :attr
      xml_reader :inputvector, :from => :attr
      xml_reader :cia_impact, :from => :attr
      xml_reader :grace_period_expires, :from => :attr
      xml_reader :affects_policy_compliance?, :from => :attr
      
      xml_reader :exploit_desc
      xml_reader :severity_desc
      xml_reader :remediation_desc
      xml_reader :exploitability_adjustments, :as => ExploitAdjustment
      xml_reader :appendix, :as => AppendixType
      xml_reader :mitigations, :as => Mitigations
      xml_reader :annotations, :as => Annotations
    end
    
    class Flaws < Base
      xml_reader :flaws, :as => [Flaw]
    end
  end
end
