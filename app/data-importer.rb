require 'csv'
require 'uri'
require 'json'

def phone_owner(str) 
    Phone.phone_owners[str.downcase] ? Phone.phone_owners[str.downcase] : :other
end

patient_rows = CSV.read("/Users/virmani/temporary/patient-data.tsv", { :col_sep => "\t" });

File.open('/tmp/patients-data', 'a') do |file|
patient_rows.each do |pdata|
    nameparts = pdata[1].split(" ");

    given_name = nil;
    last_name = nil;

    if (nameparts.length == 1)
        last_name = nameparts[0];
        given_name = nameparts[0];
    else
        last_name = nameparts[nameparts.length - 1];
        given_name = nameparts.slice(0, nameparts.length - 1).join(" ")
    end

    dob = nil;
    if(!pdata[2].blank?)
        begin
            dob = Date.strptime(pdata[2], "%m/%d/%Y")
        rescue ArgumentError
            #ignore this for now
        end
    end

    if (dob == nil)
        dob = Date.strptime("1/1/1900", "%m/%d/%Y");
    end

    present_same = false;
    present_address = nil;

    if(pdata[8].blank? || pdata[8].casecmp('do') == 0)
        present_same = true;
    else
        present_address = pdata[8];
    end

    datahash = {
        'given_name' => given_name,
        'last_name' => last_name,
        'date_of_birth' => dob,
        'fathers_name' => pdata[3],
        'fathers_occupation' => pdata[4],
        'mothers_name' => pdata[5],
        'mothers_occupation' => pdata[6],
        'permanent_address' => pdata[7],
        'permanent_district' => pdata[9],
        'present_permanent_same' => present_same,
        'present_address' => present_address
    };

    patient = Patient.new(datahash)
    if(!patient.valid?)
        print JSON.pretty_generate(datahash);
        print JSON.pretty_generate(patient.errors.inspect);
    else
        patient.save
    end
    
    phones='phones'

    if(!pdata[10].blank? && !pdata[11].blank? && pdata[11].casecmp('dr') != 0)
        phh = {
            'number' => pdata[10],
            'phone_type' => 'mobile',
            'phone_owner' => phone_owner(pdata[11])
        }

        ph = patient.phones.new(phh)

        if(!ph.valid?)
            print JSON.pretty_generate(phh);
            print JSON.pretty_generate(ph.errors.inspect);
        else
            ph.save
        end
    
        # Store the phone1 here
    end

    if(!pdata[12].blank? && !pdata[13].blank? && pdata[13].casecmp('dr') != 0)
        phh = {
            'number' => pdata[12],
            'phone_type' => 'mobile',
            'phone_owner' => phone_owner(pdata[13])
        }

        ph = patient.phones.new(phh)
        
        if(!ph.valid?)
            print JSON.pretty_generate(phh);
            print JSON.pretty_generate(ph.errors.inspect);
        else
            ph.save
        end
    end

    if(!pdata[14].blank? && !pdata[15].blank? && pdata[15].casecmp('dr') != 0)
        phh = {
            'number' => pdata[14],
            'phone_type' => 'mobile',
            'phone_owner' => phone_owner(pdata[15])
        }

        ph = patient.phones.new(phh)
        
        if(!ph.valid?)
            print JSON.pretty_generate(phh);
            print JSON.pretty_generate(ph.errors.inspect);
        else
            ph.save
        end
    end

    if(!pdata[16].blank? )
        phh = {
            'number' => pdata[16],
            'phone_type' => 'landline',
            'phone_owner' => 'self'
        }

        ph = patient.phones.new(phh)
        
        if(!ph.valid?)
            print JSON.pretty_generate(phh);
            print JSON.pretty_generate(ph.errors.inspect);
        else
            ph.save
        end
    end

    emails = 'emails'

    if(!pdata[17].blank? )
        emh = {
            'email_address' => pdata[17],
            'email_owner' => 'self'
        }

        em = patient.emails.new(emh)
        
        if(!em.valid?)
            print JSON.pretty_generate(emh);
            print JSON.pretty_generate(em.errors.inspect);
        else
            em.save
        end
    end

    if(!pdata[18].blank? )
        emh = {
            'email_address' => pdata[18],
            'email_owner' => 'self'
        }

        em = patient.emails.new(emh)
        
        if(!em.valid?)
            print JSON.pretty_generate(emh);
            print JSON.pretty_generate(em.errors.inspect);
        else
            em.save
        end
    end

    if(!pdata[20].blank?)
        begin
            gdrive_uri = URI.parse(pdata[20]);
            if(gdrive_uri != nil && gdrive_uri.scheme == "https" && gdrive_uri.host == "drive.google.com")
                folder_id = gdrive_uri.path.split("/").last
                
                gf = patient.build_google_drive_folder({'google_id' => folder_id});

                if(!gf.valid?)
                    print JSON.pretty_generate(folder_id);
                    print JSON.pretty_generate(gf.errors.inspect);
                else
                    gf.save
                end        
            end
        rescue URI::InvalidURIError
            #ignore and move on
        end
    end
    

    #file.puts JSON.pretty_generate(datahash);
end

end

