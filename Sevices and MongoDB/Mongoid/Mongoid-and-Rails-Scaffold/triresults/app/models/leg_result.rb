class LegResult
    include Mongoid::Document

    field :secs, type: Float

    after_initialize do |doc|
        doc.calc_ave
    end

    # empty calback method
    def calc_ave
    end

    def secs= val
        self[:secs] = val
        calc_ave
    end

end
