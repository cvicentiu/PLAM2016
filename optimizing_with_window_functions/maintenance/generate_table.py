import datetime
import random

def gen_activity_table(n_rows=100,
                       n_machines=10000,
                       filename='maintenance_activity.sql'):
    random.seed(42)
    gauss_distrib = random.gauss(5, 3)
    with open(filename, 'w') as f:
        f.write('create table maintenance_activity (\n' +
                '   pk int, time datetime, machine_id int\n' +
                ');\n\n');

        pk = 0
        current_time = datetime.datetime.now()
        for i in xrange(n_machines):
            machine_current_time = current_time
            avg_delta_time = datetime.timedelta(hours=random.gauss(5, 3) + 19)
            f.write('insert into maintenance_activity values\n')
            for _ in xrange(n_rows - 1):
                pk += 1
                f.write('(' + str(pk) + ', \'' + machine_current_time.isoformat(sep=' ') +
                        '\', ' + str(i) + '),\n')
                delta_time = avg_delta_time +  datetime.timedelta(hours=random.gauss(2, 2))
                machine_current_time = machine_current_time + delta_time

            pk += 1
            f.write('(' + str(pk) + ', \'' + machine_current_time.isoformat(sep=' ') +
                    '\', ' + str(i) + ');\n')

gen_activity_table()
