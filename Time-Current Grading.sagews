︠adf2b801-c3fb-4be8-b709-93d6ddaa8092s︠
def i2t(icont, tmax=10000, k=2.5e6, color='red', zorder=10, alpha=1, thickness=1.5, label='i2t', **kwargs):
    continous_rating = line([(icont,tmax),(icont,k/(icont^2))], color=color, zorder=10, alpha=1, thickness=thickness, legend_label=None, **kwargs)
    # I^2t characteristic
    f(i) = k/(i^2)
    short_time_rating = plot(f(i),(i, icont, imax), color=color, zorder=10, alpha=1, thickness=thickness, legend_label=label, **kwargs)
    return short_time_rating + continous_rating

def find_i2t_k(t,i):
    return (i^2)*t

def find_t_for_i(i,k):
    return k/(i^2)

def curve(c='SI', tms=0.1, ipu=100, tdef=1, tmax=1, imax=10000, instpu=None, insttime=0.02, color='blue', zorder=10, alpha=1, thickness=1.5, label='curve', **kwargs):
    c = c.upper()
    if c == 'SI':
        # Standard Inverse curve to IEC 60255
        f(i) = tms*(0.14/((i/ipu)^0.02-1))
    elif c == 'VI':
        # Very Inverse curve to IEC 60255
        f(i) = tms*(13.5/((i/ipu)^1-1))
    elif c == 'EI"':
        # Long time standby earth fault to IEC 60255
        f(i) = tms*(0.14/((i/ipu)^0.02-1))
    elif c == 'LTSEF':
        # Long time standby earth fault to IEC 60255
        f(i) = tms*(120/((i/ipu)^1-1))

    if c == 'DEF':
        # definite time characteristic
        pu_line = line([(ipu,tdef),(ipu,tmax)], color=color, zorder=zorder, alpha=alpha, thickness=thickness, legend_label=None, **kwargs)
        time_line = line([(ipu,tdef),(imax,tdef)], color=color, zorder=zorder, alpha=alpha, thickness=thickness, legend_label=label, **kwargs)
        return pu_line + time_line
    else:
        if instpu is not None:
            inst = line([(instpu,f(instpu)),(instpu,insttime)], color=color, zorder=10, alpha=1, thickness=thickness, legend_label=None, **kwargs)
            curve = plot(f(i), (i, ipu+0.05, imax), plot_points=400, color=color, zorder=zorder, alpha=alpha, thickness=thickness, legend_label=label, **kwargs)
            return inst + curve
        else:
            return plot(f(i), (i, ipu+0.05, imax), plot_points=400, color=color, zorder=zorder, alpha=alpha, thickness=thickness, legend_label=label, **kwargs)

# lesser of two curves for Sinapati

︡6310081b-10cc-4384-bc67-358024cb488b︡{"done":true}︡
︠63e29844-6d24-47f1-9aa6-e946c36251fes︠
imax = 10e3 # maximum current to show on graph
tmax = 10e4 # maximum time to shown on graph

k=find_i2t_k(t=10,i=500) # Calculate i^2*t for t=10 s and i=500 A
k2=find_i2t_k(t=3,i=1905) # Calculate i^2*t for t=3 s and i=1905 A

a = i2t(icont=45, tmax=tmax, k=k, color='red', label="$I^2t$ for 45 A cont. NER")
a += i2t(icont=45, tmax=tmax, k=k2, color='red', label="$I^2t$ for 1905 A for 3 s ET") 
a += curve(c='def', ipu=45, tdef=125, imax=imax, tmax=tmax, color='blue', label='EF(DefT)LV3')
a += curve(c='def', ipu=100, tdef=2, imax=imax, tmax=tmax, color='green', label='EF(DefT)LV2')

a += curve('si', ipu=55, tms=0.2, imax=1000, instpu=1000, color='purple', label="An SI Curve, looking for love")
a += line([(45,250),(imax,250)], color='purple', zorder=10, alpha=1, thickness=1.5, legend_label='Rated time at EF(DefT)LV1 pickup', linestyle=':')
a += polygon([(45,250),(45,find_t_for_i(45,k)),(100,250)],color='pink', legend_label='Area protected by EF(DefT)LV3')


b=show(a, figsize=[50,10], xmin=0, xmax=imax, ymin=0, ymax=tmax, aspect_ratio=0.3, scale='loglog',
      gridlines="minor",  
      hgridlinesstyle=dict(color="grey", linewidth=1.0, linestyle="-", zorder=-1),
      vgridlinesstyle=dict(color="grey", linewidth=1.0, linestyle="-", zorder=-1),
      axes_labels=['$I$ pri. $A$','$t$ (sec)'],
      axes_labels_size=1.5)

a.save('test.svg', figsize=[50,10], xmin=0, xmax=imax, ymin=0, ymax=tmax, aspect_ratio=0.3, scale='loglog',
      gridlines="minor",  
      hgridlinesstyle=dict(color="grey", linewidth=1.0, linestyle="-", zorder=-1),
      vgridlinesstyle=dict(color="grey", linewidth=1.0, linestyle="-", zorder=-1),
      axes_labels=['$I$ pri. $A$','$t$ (sec)'],
      axes_labels_size=1.5)

a.save('test.png', figsize=[50,10], xmin=0, xmax=imax, ymin=0, ymax=tmax, aspect_ratio=0.3, scale='loglog',
      gridlines="minor",  
      hgridlinesstyle=dict(color="grey", linewidth=1.0, linestyle="-", zorder=-1),
      vgridlinesstyle=dict(color="grey", linewidth=1.0, linestyle="-", zorder=-1),
      axes_labels=['$I$ pri. $A$','$t$ (sec)'],
      axes_labels_size=1.5)
︡c11c58f4-1b6d-4ac7-8944-02410dcd9530︡{"file":{"filename":"/projects/7c03372f-28a6-4f1a-9c7b-9a849d8e9517/.sage/temp/compute6-us/31531/tmp_OvR7o2.svg","show":true,"text":null,"uuid":"ded1d4c4-530f-4137-883d-a30fa1cecaf7"},"once":false}︡{"html":"<div align='center'></div>"}︡{"done":true}︡
︠269fa228-b197-47d9-b073-6f64889ee66es︠
︡260affad-caa0-4b79-b5f2-71208c7fb608︡{"done":true}︡









