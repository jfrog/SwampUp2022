# create release bundle
jf ds rbc --spec=rb-spec.json rb_swamp 1.0.0 --desc="release candidate"

# sign release bundle
jf ds rbs rb_swamp 1.0.0

# distribute release bundle
jf ds rbd --dist-rules=new-dist-rules.json rb_swamp 1.0.0