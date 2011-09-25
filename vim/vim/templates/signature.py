# -*- coding: utf-8 -*-
import os
import sys
import datetime
filename = "untitled"
if len(sys.argv):
    filename = sys.argv[1].strip()

print """# -*- coding: utf-8 -*-
#
# %(filename)s
# created by %(username)s on %(today)s
#""" % {
        'filename' : filename,
        'username' : os.environ['USER'],
        'today' :datetime.datetime.now().strftime('%Y/%m/%d')
}
