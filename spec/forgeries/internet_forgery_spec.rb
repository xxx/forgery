require File.dirname(__FILE__) + '/../spec_helper'

describe InternetForgery do
  describe ".user_name" do
    it "should return a username that is lowercase" do
      InternetForgery.user_name.should only_contain(BasicForgery::LOWER_ALPHA)
    end
  end

  it "should return a top level domain" do
    Forgery.dictionaries[:top_level_domains].should include(InternetForgery.top_level_domain)
  end

  describe ".domain_name" do
    it "should return a domain name that contains a lowercase company name" do
      downcase_company_name = InternetForgery.domain_name.split('.').first
      Forgery.dictionaries[:company_names].any?{ |cn| cn =~ /#{downcase_company_name}/i }
    end

    it "should return a domain name that contains a top level domain" do
      Forgery.dictionaries[:top_level_domains].should include(InternetForgery.domain_name.split('.').last)
    end
  end

  describe ".email_address" do
    it "should match the email format" do
      InternetForgery.email_address.should match(/.+@.+\.(#{Forgery.dictionaries[:top_level_domains].join("|")})/)
    end
  end

  describe ".cctld" do
    it "should return a country-code top level domain" do
      Forgery.dictionaries[:country_code_top_level_domains].should include(InternetForgery.cctld)
    end

    it "should return the cctld in correct two-letter format" do
      InternetForgery.cctld.should =~ /\A[a-z]{2}\Z/
    end
  end
end
