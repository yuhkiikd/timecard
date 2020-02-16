module AffiliationHelper
  def affiliation_select
    Affiliation.select("id", "name")
  end
end