require 'rubygems'
require 'ffi'

module GEOS
  extend FFI::Library
  ffi_lib "/Library/Frameworks/GEOS.framework/Versions/3/unix/lib/libgeos_c.dylib"
  attach_function :GEOSWKTReader_create, [], :pointer
  attach_function :GEOSWKTReader_destroy,[:pointer], :void
  attach_function :GEOSWKTReader_read,[:pointer, :string], :pointer

  attach_function :GEOSWKTWriter_create, [], :pointer
  attach_function :GEOSWKTWriter_destroy,[:pointer], :void
  attach_function :GEOSWKTWriter_write,[:pointer, :pointer], :string  
end

require 'GEOS'
require 'geo_ruby'

include GeoRuby::SimpleFeatures

readr = GEOS.GEOSWKTReader_create
writr = GEOS.GEOSWKTWriter_create

geom = GEOS.GEOSWKTReader_read readr, Point.from_lon_lat(1.523, 2.2345).as_wkt
wkt = GEOS.GEOSWKTWriter_write writr, geom

puts wkt




###COMPLETE RUBBISH FOLLOWS...
#puts GEOS.GEOSisValid geom1
#wkt2 = Point.from_lon_lat(50, 50).as_wkt
#geom2 = GEOS.GEOSWKTReader_read readr, wkt2
#dist_ptr = FFI::MemoryPointer.new :double
#coords = GEOS.GEOSDistance geom1, geom2, dist_ptr
#puts coords
#puts dist_ptr.get_double(0)
##geom = GEOS.GEOSGeomFromWKT(Point.from_lon_lat(1.523, 2.2345).as_wkt)
#wkt = GEOS.GEOSGeomToWKT(geom)
#puts wkt

=begin
/* WKT Writer */
extern GEOSWKTWriter GEOS_DLL *GEOSWKTWriter_create();
extern void GEOS_DLL GEOSWKTWriter_destroy(GEOSWKTWriter* writer);
extern char GEOS_DLL *GEOSWKTWriter_write(GEOSWKTWriter* reader, const GEOSGeometry* g);
=end