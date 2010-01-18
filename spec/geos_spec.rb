require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Geos" do
  
  it "should import a geom from WKT" do
    readr = GEOS.GEOSWKTReader_create
    geom = GEOS.GEOSWKTReader_read readr, "POINT(1.523 2.2345)"
    fail "find a way to test this    "
  end

  it "should export a geom to WKT" do
    readr = GEOS.GEOSWKTReader_create
    writr = GEOS.GEOSWKTWriter_create
    
    geom = GEOS.GEOSWKTReader_read readr, "POINT(1.523 2.2345)"
    wkt = GEOS.GEOSWKTWriter_write writr, geom
    fail "find a way to test this"
  end
  
  it "should import a geom from WKB"

  it "should export a geom to WKB"

  it "fails" do
    fail "hey buddy, you should probably rename this file and start specing for real"
  end
end
