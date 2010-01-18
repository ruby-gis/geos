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
    raise("Couldn't find geos C API on your system")
  end

  attach_function :GEOSWKTReader_create, [], :pointer
  attach_function :GEOSWKTReader_destroy, [:pointer], :void
  attach_function :GEOSWKTReader_read, [:pointer, :string], :pointer

  attach_function :GEOSWKTWriter_create, [], :pointer
  attach_function :GEOSWKTWriter_destroy, [:pointer], :void
  attach_function :GEOSWKTWriter_write, [:pointer, :pointer], :string
end