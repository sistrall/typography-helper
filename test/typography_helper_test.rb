require 'test/unit'
require File.dirname(__FILE__) + '/../lib/typography_helper'

require 'rubygems'
require 'rubypants'

class TypographyHelperTest < Test::Unit::TestCase

  # Explicitly include the module
  include TypographyHelper

  def setup
    @test_string1 = "<p>OU & UT</p>"
    @test_string2 = "<p>'Meeting at 9 P.M.'</p>"
    @test_string3 = '<p>eat at <a class="some_class">joe\'s</a></p>'
    @test_string4 = '<h2>Standard HTML Header Tag -- fun</h2>'
    @test_string5 = '<h1>this is THE title</h1><p>"this is a paragraph"</p>'
    @test_string6 = '<a href="http://topfunky.com/clients/peepcode/REST-cheatsheet.pdf">Handy Cheat Sheet</a>'
    @test_string7 = '<code>Test CAPS and & in code</code> & and CAPS outside'
    @test_string8 = '<p>Testing closing inline tag with a space after it <span>span</span> </p>'
    @test_string9 = '<a href="/the-project/related-links/">Related links</a>'
  end

  def test_amp
    assert_equal '<p>OU <span class="amp">&amp;</span> UT</p>', amp(@test_string1)
    assert_equal '<p>\'Meeting at 9 P.M.\'</p>', amp(@test_string2)
    assert_equal '<p>eat at <a class="some_class">joe\'s</a></p>', amp(@test_string3)
    assert_equal '<h2>Standard HTML Header Tag -- fun</h2>', amp(@test_string4)
    assert_equal '<h1>this is THE title</h1><p>"this is a paragraph"</p>', amp(@test_string5)
    assert_equal '<code>Test CAPS and & in code</code> <span class="amp">&amp;</span> and CAPS outside', amp(@test_string7)
  end

  def test_caps
    assert_equal '<p><span class="caps">OU</span> & <span class="caps">UT</span></p>', caps(@test_string1)
    assert_equal '<p>\'Meeting at 9 <span class="caps">P.M.</span>\'</p>', caps(@test_string2)
    assert_equal '<p>eat at <a class="some_class">joe\'s</a></p>', caps(@test_string3)
    assert_equal '<h2>Standard <span class="caps">HTML</span> Header Tag -- fun</h2>', caps(@test_string4)
    assert_equal '<h1>this is <span class="caps">THE</span> title</h1><p>"this is a paragraph"</p>', caps(@test_string5)
    assert_equal '<a href="http://topfunky.com/clients/peepcode/REST-cheatsheet.pdf">Handy Cheat Sheet</a>', caps(@test_string6)
    assert_equal '<code>Test CAPS and & in code</code> & and <span class="caps">CAPS</span> outside', caps(@test_string7)
  end

  def test_widont
    assert_equal '<p>OU &&nbsp;UT</p>', widont(@test_string1)
    assert_equal '<p>\'Meeting at 9&nbsp;P.M.\'</p>', widont(@test_string2)
    assert_equal '<p>eat at&nbsp;<a class="some_class">joe\'s</a></p>', widont(@test_string3)
    assert_equal '<h2>Standard HTML Header Tag --&nbsp;fun</h2>', widont(@test_string4)
    assert_equal '<h1>this is THE&nbsp;title</h1><p>"this is a&nbsp;paragraph"</p>', widont(@test_string5)
    assert_equal '<p>Testing closing inline tag with a space after it&nbsp;<span>span</span> </p>', widont(@test_string8)
    assert_equal '<a href="/the-project/related-links/">Related links</a>', widont(@test_string9)
  end

  def test_inital_quotes
    assert_equal '<p>OU & UT</p>', initial_quotes(@test_string1)
    assert_equal '<p><span class="quo">\'</span>Meeting at 9 P.M.\'</p>', initial_quotes(@test_string2)
    assert_equal '<p>eat at <a class="some_class">joe\'s</a></p>', initial_quotes(@test_string3)
    assert_equal '<h2>Standard HTML Header Tag -- fun</h2>', initial_quotes(@test_string4)
    assert_equal '<h1>this is THE title</h1><p><span class="dquo">"</span>this is a paragraph"</p>', initial_quotes(@test_string5)
  end
  
  def test_rubypants
    assert_equal '<p>OU & UT</p>', rubypants(@test_string1)
    assert_equal '<p>&#8216;Meeting at 9 P.M.&#8217;</p>', rubypants(@test_string2)
    assert_equal '<p>eat at <a class="some_class">joe&#8217;s</a></p>', rubypants(@test_string3)
    assert_equal '<h2>Standard HTML Header Tag &#8211; fun</h2>', rubypants(@test_string4)
    assert_equal '<h1>this is THE title</h1><p>&#8220;this is a paragraph&#8221;</p>', rubypants(@test_string5)
  end

  def test_outfit
    assert_equal '<p><span class="caps">OU</span> <span class="amp">&amp;</span>&nbsp;<span class="caps">UT</span></p>', rubyoutfit(@test_string1)
    assert_equal '<p><span class="quo">&#8216;</span>Meeting at 9&nbsp;<span class="caps">P.M.</span>&#8217;</p>', rubyoutfit(@test_string2)
    assert_equal '<p>eat at&nbsp;<a class="some_class">joe&#8217;s</a></p>', rubyoutfit(@test_string3)
    assert_equal '<h2>Standard <span class="caps">HTML</span> Header Tag &#8211;&nbsp;fun</h2>', rubyoutfit(@test_string4)
    assert_equal '<h1>this is <span class="caps">THE</span>&nbsp;title</h1><p><span class="dquo">&#8220;</span>this is a&nbsp;paragraph&#8221;</p>', rubyoutfit(@test_string5)
  end

end
