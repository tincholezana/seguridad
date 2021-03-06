// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package ar.edu.um.pruebaseguridad.domain;

import ar.edu.um.pruebaseguridad.domain.Persona;
import ar.edu.um.pruebaseguridad.domain.PersonaDataOnDemand;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.stereotype.Component;

privileged aspect PersonaDataOnDemand_Roo_DataOnDemand {
    
    declare @type: PersonaDataOnDemand: @Component;
    
    private Random PersonaDataOnDemand.rnd = new SecureRandom();
    
    private List<Persona> PersonaDataOnDemand.data;
    
    public Persona PersonaDataOnDemand.getNewTransientPersona(int index) {
        Persona obj = new Persona();
        setNombre(obj, index);
        return obj;
    }
    
    public void PersonaDataOnDemand.setNombre(Persona obj, int index) {
        String nombre = "nombre_" + index;
        obj.setNombre(nombre);
    }
    
    public Persona PersonaDataOnDemand.getSpecificPersona(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Persona obj = data.get(index);
        Long id = obj.getId();
        return Persona.findPersona(id);
    }
    
    public Persona PersonaDataOnDemand.getRandomPersona() {
        init();
        Persona obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return Persona.findPersona(id);
    }
    
    public boolean PersonaDataOnDemand.modifyPersona(Persona obj) {
        return false;
    }
    
    public void PersonaDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = Persona.findPersonaEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Persona' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Persona>();
        for (int i = 0; i < 10; i++) {
            Persona obj = getNewTransientPersona(i);
            try {
                obj.persist();
            } catch (final ConstraintViolationException e) {
                final StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                    final ConstraintViolation<?> cv = iter.next();
                    msg.append("[").append(cv.getRootBean().getClass().getName()).append(".").append(cv.getPropertyPath()).append(": ").append(cv.getMessage()).append(" (invalid value = ").append(cv.getInvalidValue()).append(")").append("]");
                }
                throw new IllegalStateException(msg.toString(), e);
            }
            obj.flush();
            data.add(obj);
        }
    }
    
}
