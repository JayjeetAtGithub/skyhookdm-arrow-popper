import urllib
import pyarrow as pa
import pyarrow.dataset as ds
import pyarrow.parquet as pq
import pyarrow.rados as rados

# write test objects
source = "rados:///etc/ceph/ceph.conf?cluster=ceph&pool=test-pool"
object_ids = ['obj.0', 'obj.1', 'obj.2', 'obj.3']
data = [
        pa.array(range(5), type='int64'),
        pa.array([-10, -5, 0, 5, 10], type='int64')
    ]
table = pa.table(data, names=('a', 'b'))
for id in object_ids:
	rados.write_to_dataset(source, table, id)

# read and scan table
dataset = ds.dataset(
        source="rados:///etc/ceph/ceph.conf?cluster=ceph \
                &pool=test-pool&ids={}".format(
            urllib.parse.quote(
                str(object_ids), safe='')
        )
    )

print(dataset.to_table(filter=(ds.field('a') > 2)).to_pandas())
