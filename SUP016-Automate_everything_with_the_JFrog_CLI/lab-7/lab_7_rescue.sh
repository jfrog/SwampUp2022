# create release bundle
jf ds rbc --spec=new-rb-spec.json new_rb_swamp 5.0.0

# sign release bundle
jf ds rbs new_rb_swamp 5.0.0

 # distribute release bundle
 jf ds rbd --dist-rules=new-dist-rules.json new_rb_swamp 5.0.0