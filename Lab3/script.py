import random
import string

import os, sys
import datetime
import psycopg2
import pyexcel as pyexcel

import json

tables = [
    'people',
    'driver_license',
    'inspector',
    'machine_directory',
    'violation',
    'dir_categories',
    'categories',
    'car',
    'fine',
    'dtp',
    'details',
    'damage_car',
    'damage',
    'injured',
    'guilty',
    'osago'
]

ranks = [
    'Radovoi',
    'Mladshi sergant',
    'Sergant',
    'Starshi sergant',
    'Starshina',
    'Praporsshik',
    'Mladshi praporshik',
    'Leidenant'
]


try:
    conn = psycopg2.connect(dbname='GIPDD', user='postgres',
                            password='1', host='localhost')
except:
    print("Can not connect")


def print_tables():
    for table in tables:
        print_table(table)


def print_table(table):
    with conn.cursor() as cursor:
        print('\n%s' % table)
        cursor.execute('SELECT * FROM %s' % table)
        for row in cursor:
            print(row)
    cursor.close()


def get_table(table):
    with conn.cursor() as cursor:
        field = []
        cursor.execute('SELECT * FROM %s' % table)
        field.append([row[0] for row in cursor.description])
        field += cursor.fetchall()
        return field


def get_value(table, column_neme, str_number):
    column = get_number_column(table, column_neme)
    if column == None:
        return -1

    if (column >= 0):
        return table[str_number][column]
    return None


def get_number_column(table, column_neme):
    for i in range(len(table[0])):
        if (table[0][i] == column_neme):
            return i
    return None


def find_value(table, column_neme, value):
    column = get_number_column(table, column_neme)
    if column == None:
        return -1

    if (column >= 0):
        for str in range(1, len(table)):
            if(int(table[str][column]) == int(value)):
                return [str, column]
        return None
    else:
        return -1


def get_list_int(table, colum_name, min, max, limit = 1):
    value = []
    for i in range(min, max):
        if (find_value(table, colum_name, i) == None):
            value.append(i)
            if len(value) == limit:
                break
    return value


def clear_db():
    with conn.cursor() as cursor:
        for table in tables:
            cursor.execute("TRUNCATE %s RESTART IDENTITY CASCADE" % table)
    cursor.close()


def randstr(length):
    letters = string.ascii_lowercase
    return ''.join(random.choice(letters) for i in range(length))


def generate_dir_categories():
    table = get_table('dir_categories')
    num = len(table)
    if num <= 1:
        with conn.cursor() as cursor:
            cursor.execute("INSERT INTO dir_categories (id, name) VALUES (%s,%s)",
                           (1, 'A'))
            conn.commit()
            cursor.execute("INSERT INTO dir_categories (id, name) VALUES (%s,%s)",
                           (2, 'B'))
            conn.commit()
            cursor.execute("INSERT INTO dir_categories (id, name) VALUES (%s,%s)",
                           (3, 'C'))
            conn.commit()
            cursor.execute("INSERT INTO dir_categories (id, name) VALUES (%s,%s)",
                           (4, 'D'))
            conn.commit()
            cursor.execute("INSERT INTO dir_categories (id, name) VALUES (%s,%s)",
                           (5, 'E'))
            conn.commit()


def generate_people(size):
    if size > 0:
        with conn.cursor() as cursor:
            for i in range(0, size):
                cursor.execute(
                    "INSERT INTO people(first_name, last_name, middle_name) VALUES (%s,%s,%s)",
                    (randstr(15), randstr(15), randstr(15)))
                conn.commit()


def generate_driver_license(size):
    if size > 0:
        people_table = get_table("people")
        size_people = len(people_table)
        if size_people > 0:
            people_key = []
            max_ints = size
            dl_table = get_table('driver_license')

            rand_number = get_list_int(dl_table, "number", 1, 1000000, size)
            if max_ints > len(rand_number):
                max_ints = len(rand_number)
            categories = get_list_int(dl_table, "categories", 1, 1000000, size)
            if max_ints > len(categories):
                max_ints = len(categories)
            people = get_list_int(dl_table, "people_id", 1, size_people, size)
            for j in range(0, len(people)):
                people_key.append(get_value(people_table, "id", people[j]))
            if max_ints > len(people_key):
                max_ints = len(people_key)
            if max_ints < size:
                print('Only ' + str(max_ints) + ' entries can be added to the driver_licens table.')

            with conn.cursor() as cursor:
                for i in range(0, max_ints):

                        y = random.randint(8, 20)
                        m = random.randint(1, 12)
                        d = random.randint(1, 28)

                        unit_gipdd = 'GIPDD ' + str(random.randrange(7800, 7899))
                        cursor.execute("INSERT INTO driver_license (number, categories, data_and_time_of_issue, end_date_and_time, unit_gipdd, people_id) VALUES (%s,%s,%s,%s,%s,%s)",
                                       (rand_number[i], categories[i], datetime.date(2000 + y, m, d),
                                        datetime.date(2000 + y + 10, m, d), unit_gipdd, people_key[i]))
                        probability = 0.3
                        quantity = 0
                        for j in range(1, 6):
                            rand = random.random()
                            if rand < probability:
                                quantity += 1
                                cursor.execute("INSERT INTO categories (categories, id_categories) VALUES (%s,%s)", (categories[i], j))
                            if j == 4 and quantity == 0:
                                cursor.execute("INSERT INTO categories (categories, id_categories) VALUES (%s,%s)", (categories[i], 1))
                conn.commit()


def generate_inspector(sizeInsp):
    if sizeInsp > 0:
        people_table = get_table('people')
        size_peop = len(people_table)
        if size_peop > 0:
            people_key = []
            max_ints = sizeInsp
            insp_table = get_table('inspector')

            police_certificate = get_list_int(insp_table, "police_certificate", 1, 1000000, sizeInsp)
            if max_ints > len(police_certificate):
                max_ints = len(police_certificate)
            people = get_list_int(insp_table, "people_id", 1, size_peop, sizeInsp)
            for j in range(0, len(people)):
                people_key.append(get_value(people_table, "id", people[j]))
            if max_ints > len(people_key):
                max_ints = len(people_key)
            if max_ints < sizeInsp:
                print('Only ' + str(max_ints) + ' entries can be added to the inspector table.')

            with conn.cursor() as cursor:
                for i in range(0, max_ints):
                    rand_rank = random.randrange(0, len(ranks))
                    cursor.execute(
                        "INSERT INTO inspector (police_certificate, rank, people_id) VALUES (%s,%s,%s)",
                        (police_certificate[i], ranks[rand_rank], people_key[i]))
                conn.commit()


def generate_violation(size):
    if size > 0:
        max_ints = size
        violation_table = get_table('violation')
        title = get_list_int(violation_table, "id", 1, 1000000, size)
        if max_ints > len(title):
            max_ints = len(title)
        with conn.cursor() as cursor:
            for i in range(0, max_ints):
                cursor.execute("INSERT INTO violation (title, punishment) VALUES (%s,%s)",
                               ('Article ' + str(title[i]), randstr(15)))
            conn.commit()


def generate_fine(sizeFine):
    if sizeFine > 0:

        insp_table = get_table('inspector')
        size_Insp = len(insp_table)
        dl_table = get_table('driver_license')
        size_DL = len(dl_table)
        viol_table = get_table('violation')
        size_Viol = len(viol_table)
        if size_Insp > 0 and size_DL > 0 and size_Viol > 0:
            with conn.cursor() as cursor:
                for i in range(0, sizeFine):
                    insp_rand = random.randint(1, size_Insp - 1)
                    insp = get_value(insp_table, "id", insp_rand)

                    dl_rand = random.randint(1, size_DL - 1)
                    dl = get_value(dl_table, "id", dl_rand)

                    viol_rand = random.randint(1, size_Viol - 1)
                    viol = get_value(viol_table, "id", viol_rand)

                    y = random.randint(10, 20)
                    m = random.randint(1, 12)
                    d = random.randint(1, 28)

                    cursor.execute(
                        "INSERT INTO fine (driver_license, police_certificate, data_and_time, id_violation) VALUES (%s,%s, %s,%s)",
                        (dl, insp, datetime.date(2000 + y, m, d), viol))

                conn.commit()


def generate_machine_directory(size):
    if size > 0:
        with conn.cursor() as cursor:
            for i in range(0, size):
                cursor.execute("INSERT INTO machine_directory (brand, model) VALUES (%s,%s)",
                               (randstr(3), randstr(15)))
            conn.commit()


def generate_car(sizeCar):
    if sizeCar > 0:
        md_table = get_table('machine_directory')
        size_md = len(md_table)
        categories_table = get_table('dir_categories')
        size_categories = len(categories_table)
        people_table = get_table('people')
        size_people = len(people_table)
        if size_md > 0 and size_categories > 0 and size_people > 0:
            md_key = []
            categories_key = []
            people_key = []
            max_ints = sizeCar
            car_table = get_table('car')

            registration_plate = get_list_int(car_table, "registration_plate", 1, 1000000, sizeCar)
            if max_ints > len(registration_plate):
                max_ints = len(registration_plate)
            for j in range(0, sizeCar):
                md = random.randint(1, size_md - 1)
                md_key.append(get_value(md_table, "id", md))
            for j in range(0, sizeCar):
                categories = random.randint(1, size_categories - 1)
                categories_key.append(get_value(people_table, "id", categories))
            for j in range(0, sizeCar):
                people = random.randint(1, size_md - 1)
                people_key.append(get_value(people_table, "id", people))

            if max_ints < sizeCar:
                print('Only ' + str(max_ints) + ' entries can be added to the driver_licens table.')
            with conn.cursor() as cursor:
                for i in range(0, max_ints):
                    cursor.execute(
                        "INSERT INTO car (registration_plate, brand_and_monel, categories, people_id) VALUES (%s,%s, %s,%s)",
                        (registration_plate[i], md_key[i], categories_key[i], people_key[i]))
                    y = random.randint(17, 20)
                    m = random.randint(1, 12)
                    d = random.randint(1, 28)
                    cursor.execute(
                        "INSERT INTO osago (data_and_time_of_issue, end_date_and_time, car) VALUES (%s, %s, %s)",
                        (datetime.date(2000 + y, m, d), datetime.date(2000 + y + 1, m, d), registration_plate[i]))
                conn.commit()


def generate_dtp(size):
    if size > 0:
        car_table = get_table('car')
        size_car = len(car_table)
        details_table = get_table('details')
        size_details = len(details_table)
        if size_car > 0 and size_details > 0:
            # people_key = []
            max_ints = size
            dtp_table = get_table('dtp')

            injured = get_list_int(dtp_table, 'injured', 1, 1000000, size)
            if max_ints > len(injured):
                max_ints = len(injured)
            guilty = get_list_int(dtp_table, 'guilty', 1, 1000000, size)
            if max_ints > len(guilty):
                max_ints = len(guilty)
            damage_car = get_list_int(dtp_table, 'damage_car', 1, 1000000, size)
            if max_ints > len(damage_car):
                max_ints = len(damage_car)

            with conn.cursor() as cursor:
                for i in range(0, max_ints):
                    cursor.execute("INSERT INTO dtp (injured, guilty, damage_car) VALUES (%s, %s, %s)",
                                   (injured[i], guilty[i], damage_car[i]))

                    r = random.randint(1, 3)
                    for j in range(r):
                        rand_car_inj = random.randint(1, size_car - 1)
                        car_inj = get_value(car_table, "id", rand_car_inj)
                        cursor.execute("INSERT INTO injured (injured, injured_id) VALUES (%s, %s)",
                                        (injured[i], car_inj))

                    r = random.randint(1, 3)
                    for j in range(r):
                        rand_car_guil = random.randint(1, size_car - 1)
                        car_guil = get_value(car_table, "id", rand_car_guil)
                        cursor.execute("INSERT INTO guilty (guilty, guilty_id) VALUES (%s, %s)",
                                       (guilty[i], car_guil))

                    damage_table = get_table('damage_car')
                    r = random.randint(1, 3)
                    max_r = r
                    rand_damage = get_list_int(damage_table, 'damage', 1, 1000000, r)
                    if max_ints > len(rand_damage):
                        max_ints = len(rand_damage)
                    for j in range(max_r):
                        cursor.execute("INSERT INTO damage_car (damage_car, damage) VALUES (%s, %s)",
                                       (damage_car[i], rand_damage[j]))

                        r_damage = random.randint(1, 3)
                        for j_damage in range(r_damage):
                            rand_details = random.randint(2, size_details - 1)
                            detail = (get_value(details_table, "id", rand_details))
                            cursor.execute("INSERT INTO damage (damage, damage_id) VALUES (%s, %s)",
                                           (rand_damage[j], detail))
                conn.commit()


def generate_details(size):
    if size > 0:
        max_ints = size
        details_table = get_table('details')
        details = get_list_int(details_table, "id", 1, 1000000, size)
        if max_ints > len(details):
            max_ints = len(details)
        with conn.cursor() as cursor:
            for i in range(0, max_ints):
                cursor.execute("INSERT INTO details (id, name) VALUES (%s, %s)", (details[i], randstr(15)))
                conn.commit()


def generate(sizePeople, sizeDriver, sizeInsp, sizeViolation, sizeFine, sizeMachineDirectory ,sizeCar, sizeDetails, sizeDTP):

        generate_dir_categories()

        generate_people(sizePeople)
        generate_driver_license(sizeDriver)

        generate_inspector(sizeInsp)
        generate_violation(sizeViolation)
        generate_fine(sizeFine)

        generate_machine_directory(sizeMachineDirectory)
        generate_car(sizeCar)

        generate_details(sizeDetails)

        generate_dtp(sizeDTP)


def read_json(file_path):
    with open(file_path, 'r') as f:
        return json.loads(f.read())


def excel_export(tables):
    wold_book = dict()
    with conn.cursor() as cursor:
        for table in tables:
            field = []
            cursor.execute('SELECT * FROM %s' % table)
            field.append([row[0] for row in cursor.description])
            field += cursor.fetchall()

            wold_book[table] = field

        filename = 'gpdd_base2.xlsx'
        pyexcel.save_book_as(bookdict=wold_book, dest_file_name=filename)

        os.chdir(sys.path[0])
        os.system('start excel.exe "%s\\%s"' % (sys.path[0], filename,))




if __name__ == '__main__':
    # file = 'generate.json'
    # data = read_json(file)
    #
    # clear_db()
    # generate(data['people'], data['driver'], data['inspector'], data['violation'], data['fine'],data['machine_directory'], data['car'], data['details'], data['dtp'])
    # print_tables()

    table1 = [
        'people',
        'driver_license',
        'inspector',
        'machine_directory',
        'violation'
    ]
    excel_export(tables);

    conn.close()
