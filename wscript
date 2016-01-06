#!/usr/bin/env python

def configure(cfg):
    cfg.load('c vala')
    cfg.check_cfg(package='glib-2.0')
    cfg.check_cfg(package='gio-2.0')
    cfg.check_cfg(package='json-glib-1.0', uselib_store='JSON')
    cfg.check_cfg(package='libxml', uselib_store='XML', mandatory=False)

def build(bld):
    bld.load('c vala')

    bld.shlib(
        packages = 'json-glib-1.0 libxml-2.0',
        target   = 'mustache-glib',
        source   = bld.path.ant_glob('src/*.vala'),
        use      = 'JSON XML')

    bld(
        feature      = 'subst',
        target       = 'mustache-glib.pc',
        source       = 'mustache-glib.pc.in',
        install_path = '${LIBDIR}/pkgconfig')
