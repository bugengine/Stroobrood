# coding: utf8

import fontforge
import os

if __name__ == '__main__':
    import sys

    f = fontforge.open(sys.argv[1])
    f.fontname = u'Ströbröd' + f.fontname[len('Strobrod'):]
    f.fullname = u'Ströbröd' + f.fullname[len('Strobrod'):]
    f.familyname = u'Ströbröd'
    try: os.makedirs(os.path.dirname(sys.argv[2]))
    except OSError: pass
    f.generate(sys.argv[2],
               flags = ('apple', 'opentype'))
    f.close()
