require 'rubygems'
require 'ffi'
require 'geo_ruby'
include GeoRuby::SimpleFeatures

module GEOS
  extend FFI::Library

  paths = Array(ENV['GEOS_LIB'] || %w[
      /usr/lib/libgeos_c.so
      /usr/lib/libgeos_c.dylib
      /usr/local/lib/libgeos_c.dylib
      /usr/local/lib/libgeos_c.so
      /opt/local/lib/libgeos_c.dylib
      /opt/local/lib/libgeos_c.so
      /Library/Frameworks/GEOS.framework/Versions/3/unix/lib/libgeos_c.dylib
    ])

  begin
    ffi_lib(*paths)
  rescue LoadError => e
    raise("Couldn't find geos.so on our system")
  end


  attach_function :GEOSWKTReader_create, [], :pointer
  attach_function :GEOSWKTReader_destroy, [:pointer], :void
  attach_function :GEOSWKTReader_read, [:pointer, :string], :pointer

  attach_function :GEOSWKTWriter_create, [], :pointer
  attach_function :GEOSWKTWriter_destroy, [:pointer], :void
  attach_function :GEOSWKTWriter_write, [:pointer, :pointer], :string
end


readr = GEOS.GEOSWKTReader_create
writr = GEOS.GEOSWKTWriter_create

geom = GEOS.GEOSWKTReader_read readr.get_pointer(0), Point.from_lon_lat(1.523, 2.2345).as_wkt
wkt = GEOS.GEOSWKTWriter_write writr.get_pointer(0), geom

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
