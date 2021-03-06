// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package ar.edu.um.pruebaseguridad.web;

import ar.edu.um.pruebaseguridad.domain.Persona;
import ar.edu.um.pruebaseguridad.web.PersonaController;
import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect PersonaController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String PersonaController.create(@Valid Persona persona, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, persona);
            return "personae/create";
        }
        uiModel.asMap().clear();
        persona.persist();
        return "redirect:/personae/" + encodeUrlPathSegment(persona.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String PersonaController.createForm(Model uiModel) {
        populateEditForm(uiModel, new Persona());
        return "personae/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String PersonaController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("persona", Persona.findPersona(id));
        uiModel.addAttribute("itemId", id);
        return "personae/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String PersonaController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, @RequestParam(value = "sortFieldName", required = false) String sortFieldName, @RequestParam(value = "sortOrder", required = false) String sortOrder, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("personae", Persona.findPersonaEntries(firstResult, sizeNo, sortFieldName, sortOrder));
            float nrOfPages = (float) Persona.countPersonae() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("personae", Persona.findAllPersonae(sortFieldName, sortOrder));
        }
        return "personae/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String PersonaController.update(@Valid Persona persona, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, persona);
            return "personae/update";
        }
        uiModel.asMap().clear();
        persona.merge();
        return "redirect:/personae/" + encodeUrlPathSegment(persona.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String PersonaController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, Persona.findPersona(id));
        return "personae/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String PersonaController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Persona persona = Persona.findPersona(id);
        persona.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/personae";
    }
    
    void PersonaController.populateEditForm(Model uiModel, Persona persona) {
        uiModel.addAttribute("persona", persona);
    }
    
    String PersonaController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
